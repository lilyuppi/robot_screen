import QtQuick 2.0
import QtGraphicalEffects 1.0
Rectangle{

//    width: 150
    height: 40

    width: textButton.width + img.width + 40
    radius: 5
    color: "#03A9F4"
    property string img_src: "name"
    property string textIn: "value"
    signal click()
    Image {
        id: img
        width: parent.height - 10
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "file:/" + Data.dirApp() + "/img/" + img_src+ ".png"
    }
    Text {
        id: textButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: img.right
        anchors.leftMargin: 10
        font.pixelSize: parent.height / 2.8
        font.weight: Font.Bold
        color: "white"
        text: textIn

    }
//    layer.enabled: true
//    layer.effect: DropShadow{
//        verticalOffset: 1
//        horizontalOffset: 1
//        samples: 16
//        radius: 10
//        color: "#7f8c8d"
//    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            parent.click()
        }
    }

    /*
    layer.enabled: true
    layer.effect: DropShadow{
        verticalOffset: 1
        horizontalOffset: 1
        samples: 16
        radius: 10
        color: "#7f8c8d"
    }*/
}
