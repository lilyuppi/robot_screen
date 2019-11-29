#ifndef DATA_H
#define DATA_H
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QJsonObject>
#include <QString>
#include <QDebug>
#include <QJsonArray>
#include <QList>
#include <QObject>
#include <QQmlEngine>
#include <QDir>
#include <libxl.h>
#include <iostream>

using namespace std;
class Data : public QObject{
    Q_OBJECT
    Q_PROPERTY(int numItem READ numItem WRITE setNumItem NOTIFY numItemChanged)
    Q_PROPERTY(int numImgDetail READ numImgDetail WRITE setNumImgDetail NOTIFY numImgDetailChanged)
    Q_PROPERTY(QList<QString> listTitle READ listTitle WRITE setListTitle NOTIFY listTitleChanged)
    Q_PROPERTY(QList<QString> listSrcThum READ listSrcThum WRITE setListSrcThum NOTIFY listSrcThumChanged)
    Q_PROPERTY(QString textDetail READ textDetail WRITE setTextDetail NOTIFY textDetailChanged)
    Q_PROPERTY(QStringList listImgDetail READ listImgDetail WRITE setListImgDetail NOTIFY listImgDetailChanged)
    Q_PROPERTY(QStringList listTitleImgDetail READ listTitleImgDetail WRITE setListTitleImgDetail NOTIFY listTitleImgDetailChanged)
    Q_PROPERTY(int indexItem READ indexItem WRITE setIndexItem NOTIFY indexItemChanged)
public:
    explicit Data(QObject *parent = 0);

    Q_INVOKABLE QString dirApp();
    Q_INVOKABLE void readJson();
    Q_INVOKABLE void readData();
    Q_INVOKABLE void readListImgDetail();
    int numItem();
    int indexItem() const;
    int numImgDetail() const;
    int splitNumberFromString(string str);

    QJsonDocument openFileJson(QString dirFile);
    QList<QString> listTitle();
    QList<QString> listSrcThum();
    QString textDetail();
    QStringList listImgDetail() const;
    QStringList getAllImgInFolder(QString dirFolder);
    QStringList listTitleImgDetail() const;
    QList<QStringList> arrayListTitleImgDetail;
    QList<QStringList> arrayListSrcImgDetail;
    void readFileExcel();
    void readTextDetail();
    void readSrcAndTitDetail();
    void setListTitle(const QList<QString> &listTitle);
    void setListSrcThum(const QList<QString> &listSrcThum);
    void setTextDetail(const QString &textDetail);
    void setNumItem(const int &numItem);   

signals:
    void numItemChanged();
    void listTitleChanged();
    void listSrcThumChanged();
    void textDetailChanged();
    void indexItemChanged(int indexItem);
    void listImgDetailChanged(QStringList listImgDetail);
    void numImgDetailChanged(int numImgDetail);    
    void listTitleImgDetailChanged(QStringList listTitleImgDetail);

public slots:
    void setIndexItem(const int &indexItem);
    void setListImgDetail(QStringList listImgDetail);
    void setNumImgDetail(int numImgDetail);    
    void setListTitleImgDetail(QStringList listTitleImgDetail);

private:
    //QString m_dirApp = "/media/nvidia/ssd/catkin_ws/src/robot_screen/src/"; 
    QString m_dirApp = QDir::currentPath() + "/src/robot_screen/src/";
    QString m_dirFileJson = m_dirApp + "data/data.json";
    QJsonDocument m_recieveJson;
    int m_numItem;
    QList<QString> m_listTitle;
    QList<QString> m_listSrcThum;
    QString m_textDetail;
    int m_indexItem;
    QStringList m_listImgDetail;
    int m_numImgDetail;
    QStringList m_listTitleImgDetail;
};


#endif // DATA_H
