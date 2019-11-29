import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
Rectangle {
    id: root
    property int index
    width: Properties.sizeMain.width
    height: Properties.sizeMain.height

    signal loadedItem(int id)


    RectContainImg{
        id: rectContainImage
        anchors.left: root.left
        anchors.leftMargin: 20
        anchors.top: root.top
        anchors.topMargin: 18
        onNewID: {
            rectContainImgRelative.updateHighlight(id)
            txtTitleImg.text = Data.listTitleImgDetail[id]
        }
    }
    Item {
        id: viewTitleImg
        anchors.top: rectContainImage.bottom
        anchors.topMargin: 25
        anchors.left: root.left
        anchors.leftMargin: 30
        width: 780
        height: 120
        Text {
            id: txtTitleImg
<<<<<<< HEAD
            text: Data.listTitleImgDetail[0]
=======
//            text: "Tiêu đề ảnh"
            text: Data.listTitle[Data.indexItem]
>>>>>>> 369b30f07c39d6d3c44a4a6bae5b5cee909598e0
            width: parent.width
            font.pixelSize: 28
            font.weight: Font.Medium
//            clip: true
            elide: Text.ElideRight
        }
    }
    Rectangle{
        id: lineDownImgView
        anchors.left: rectContainImage.left
        anchors.top: rectContainImage.bottom
        anchors.topMargin: 5
        width: rectContainImage.width
        height: 1
        color: "#000000"
        opacity: 0.24
    }

    RectContainImgRelative{
        id: rectContainImgRelative
        anchors.top: root.top
        anchors.topMargin: -2
        anchors.left: rectContainImage.right
        anchors.leftMargin: 20
        onClickID: {
            rectContainImage.updateHighlight(id)
        }
    }
}
