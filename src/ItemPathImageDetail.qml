import QtQuick 2.0

ListModel {
    id: list
    Component.onCompleted: {
        updateListImg()
    }
    function updateListImg(){
        listImgPath.clear()
        for(var i = 0; i < Data.numImgDetail; i++){
            listImgPath.append({
                                   srcImgDetail: Data.listImgDetail[i],
                                   titleImgDetail: Data.listTitleImgDetail[i]
                               });
        }
    }
}
