#include "Data.h"
Data::Data(QObject *parent) : QObject(parent), m_numItem(-1), m_indexItem(-1){

}



QJsonDocument Data::openFileJson(QString dirFile){
    QFile file;
    file.setFileName(dirFile);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QJsonParseError jsonError;
    QJsonDocument recieveJson = QJsonDocument::fromJson(file.readAll(),&jsonError);
    if (jsonError.error != QJsonParseError::NoError){
        qDebug() << jsonError.errorString();
    }
    file.close();
    return recieveJson;
}



void Data::readJson()
{
    qDebug() << QDir::currentPath();
    //    QList<QVariant> list = recieveJson.toVariant().toList();
    //    QMap<QString, QVariant> map = list[0].toMap();
    //    qDebug() << map["tittle"].toString();
    //    qDebug() << map["tittle"];
    m_recieveJson = openFileJson(m_dirFileJson);
    // m_recieveJson = openFileJson("/media/nvidia/ssd/catkin_ws/src/robot_screen/src/data/data.json");
    QList<QVariant> list = m_recieveJson.toVariant().toList();
    setNumItem(list.length());
    QList<QString> temp_listTitle, temp_listSrcThum;
    for(int i = 0; i < list.length(); i++){
        QMap<QString, QVariant> map = list[i].toMap();
        temp_listTitle.append(map["title"].toString());
        temp_listSrcThum.append(map["thumbnail"].toString());
    }
    setListTitle(temp_listTitle);
    setListSrcThum(temp_listSrcThum);
    //    for(int i = 0; i < list.length(); i++){
    //        QMap<QString, QVariant> map = list[i].toMap();
    //        qDebug() << map["tittle"].toString();
    //    }
   // qDebug() << temp_listSrcThum;
}

void Data::readFileExcel()
{
    using namespace libxl;
//    qDebug() << "reading file excel";
    Book* book = xlCreateBook();
    if(book)
    {
//        qDebug() << "dirApp: " << dirApp();
        QString dirFileXls = dirApp() + "data/data.xls";
        const char *name = dirFileXls.toLocal8Bit().data(); // convert Qstring to char*
        if(book->load(name))
        {
            Sheet* sheet = book->getSheet(0); // load sheet 1
            qDebug() << "load book";
            if(sheet)
            {
                int row = 1;
                int colTiltle = 1;
                int colThumbnail = 2;
                QList<QString> temp_listTitle, temp_listSrcThum;
                while(1){
                    // get string from [row, col] in file excel
                    const char* tittle = sheet->readStr(row, colTiltle);

                    if(tittle){
//                        qDebug() << tittle;
                        temp_listTitle.append(tittle);
                    }else{
                        break;
                    }
                    const char* srcThum = sheet->readStr(row, colThumbnail);

                    if(srcThum){
                        QString dir = "/data/" + QString::number(row) + "/img/" + srcThum;
                        temp_listSrcThum.append(dir);
                    }else{
                        break;
                    }
                    row++;
                }
                //qDebug() << "row: " << row;
                int sumItem = row - 1;
                setNumItem(sumItem);
                setListTitle(temp_listTitle);
                setListSrcThum(temp_listSrcThum);
            }
            Sheet* sheet2 = book->getSheet(1); // load sheet 2
            if(sheet2){
                qDebug() << "loaded sheet 2";
                int row = 1;
                int colSrc = 0;
                int colTit = 1;
                int index = 1;
                QStringList temp_listSrc, temp_listTit;
                arrayListTitleImgDetail.clear();
                arrayListSrcImgDetail.clear();
                while(1){
                    const char* src = sheet2->readStr(row, colSrc);
                    if(src){
//                        qDebug() << src;
                        string str(src);
                        int index_in_excel = splitNumberFromString(str);
                        if(index_in_excel != index){
                            arrayListSrcImgDetail.append(temp_listSrc);
                            arrayListTitleImgDetail.append(temp_listTit);
                            temp_listSrc.clear();
                            temp_listTit.clear();
                            index++;
                        }
                        temp_listSrc.append(src);
                        const char* tit = sheet2->readStr(row, colTit);
                        temp_listTit.append(tit);
                    }else{
                        arrayListSrcImgDetail.append(temp_listSrc);
                        arrayListTitleImgDetail.append(temp_listTit);
                        break;
                    }
                    row++;
                }
//                qDebug() << arrayListTitleImgDetail;
            }
        }

        book->release();
    }

}



void Data::readTextDetail()
{
    QFile file;
    QString tmp_index = QString::number(m_indexItem);
    QString fileName_tmp = m_dirApp + "data/" + tmp_index +"/detail.txt";
    //    qDebug() << tmp_index;
    //    qDebug() << fileName_tmp;
    file.setFileName(fileName_tmp);
    if(!file.open(QIODevice::ReadOnly)){
        qDebug() << "Error in load file text detail";
    }
    QTextStream in(&file);
    QString tmp_textDetail = in.readAll();
//    qDebug() << tmp_textDetail;
    setTextDetail(tmp_textDetail);
}

void Data::readSrcAndTitDetail()
{
    readListImgDetail();
    QStringList temp_list_tit = arrayListTitleImgDetail[m_indexItem];
    setListTitleImgDetail(temp_list_tit);
    qDebug() << m_indexItem;
}

void Data::readData()
{
    readFileExcel();
}

QStringList Data::getAllImgInFolder(QString dirFolder)
{
    QDir directory(dirFolder);
//    qDebug() << dir_tmp;
    QStringList list_tmp;
    QStringList images = directory.entryList(QStringList() << "*.jpg" << "*.JPG" << "*.png" << "*.jpeg",QDir::Files);
    foreach(QString filename, images) {
        //do whatever you need to do
//        qDebug() << filename;
        list_tmp.append("file:/" + dirFolder + '/' + filename);
    }
//    qDebug() << list_tmp << list_tmp.length();
    return list_tmp;
}

void Data::readListImgDetail()
{
    QString tmp_index = QString::number(m_indexItem + 1);
    QString dir_tmp = m_dirApp + "data/" + tmp_index + "/img";
    QStringList list_tmp_from_folder = getAllImgInFolder(dir_tmp);
//    QStringList list_tmp_from_Excel = arrayListSrcImgDetail[m_indexItem];
//    QStringList list_tmp;
//    for(int i = 0; i < list_tmp_from_folder.length(); i++){
//        if(list_tmp_from_folder[i] == list_tmp_from_Excel[i]){
//            list_tmp.append(list_tmp_from_folder[i]);
//        }
//    }
    setNumImgDetail(list_tmp_from_folder.length());
    setListImgDetail(list_tmp_from_folder);
}


QString Data::dirApp()
{
    return m_dirApp;
}


//QString Data::imgPreDetail()
//{
//    if(m_listImgDetail.length() == 0){
//        return ("file:/" + m_dirApp + "/img/default.png");
//    }
//    qDebug() << "set" <<m_listImgDetail[preImgDetailPos];
//    return m_listImgDetail[preImgDetailPos];
//}


int Data::numItem(){
    return m_numItem;
}

QList<QString> Data::listTitle()
{
    return m_listTitle;
}

QList<QString> Data::listSrcThum()
{
    return m_listSrcThum;
}

QString Data::textDetail()
{
    return m_textDetail;
}


void Data::setNumItem(const int &numItem)
{
    if(m_numItem != numItem){
        m_numItem = numItem;
        emit numItemChanged();
    }
}

QStringList Data::listTitleImgDetail() const
{
    return m_listTitleImgDetail;
}

QStringList Data::listImgDetail() const
{
    return m_listImgDetail;
}



int Data::numImgDetail() const
{
    return m_numImgDetail;
}

int Data::splitNumberFromString(string str)
{
    QString s = "";
    for(int i = 0; i < str.length(); i++){
        if(str[i] == '.'){
            break;
        }else{
            s += str[i];
        }
    }
    int number = s.toInt();
//    qDebug() << number;
    return number;
}


int Data::indexItem() const
{
    return m_indexItem;
}

void Data::setIndexItem(const int &indexItem)
{
    if (m_indexItem == indexItem)
        return;

    m_indexItem = indexItem;
    readSrcAndTitDetail();
//    qDebug() << listImgDetail() << listTitleImgDetail();
    emit indexItemChanged(m_indexItem);
}

void Data::setListImgDetail(QStringList listImgDetail)
{
    if (m_listImgDetail == listImgDetail)
        return;

    m_listImgDetail = listImgDetail;
    emit listImgDetailChanged(m_listImgDetail);
}


void Data::setNumImgDetail(int numImgDetail)
{
    if (m_numImgDetail == numImgDetail)
        return;

    m_numImgDetail = numImgDetail;
    emit numImgDetailChanged(m_numImgDetail);
}

void Data::setListTitleImgDetail(QStringList listTitleImgDetail)
{
    if (m_listTitleImgDetail == listTitleImgDetail)
        return;

    m_listTitleImgDetail = listTitleImgDetail;
    emit listTitleImgDetailChanged(m_listTitleImgDetail);
}

void Data::setListTitle(const QList<QString> &listTitle)
{
    if(m_listTitle != listTitle){
        m_listTitle = listTitle;
        emit listTitleChanged();
    }
}

void Data::setListSrcThum(const QList<QString> &listSrcThum)
{
    if(m_listSrcThum != listSrcThum){
        m_listSrcThum = listSrcThum;
        emit listSrcThumChanged();
    }
}

void Data::setTextDetail(const QString &textDetail)
{
    if(m_textDetail != textDetail){
        m_textDetail = textDetail;
        emit textDetailChanged();
    }
}




