import QtQuick 2.0

ListModel{
    id: listItemModel
    Component.onCompleted: {
        Data.readData()
        var i
        for(i = 0; i < Data.numItem; i++){
            var srcThum = "file:/" + Data.dirApp() + Data.listSrcThum[i]
            listItem.model.append({
                                      title : Data.listTitle[i],
                                      srcThum : srcThum
                                  });
        }
    }
}
