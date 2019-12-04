import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0

Rectangle {
    id: root
    width: Properties.sizeImageViewRelative.width + 20
    height: Properties.sizeImageViewRelative.height + 40
    color: "#e9ebee"
    signal clickID(int id)

    function updateHighlight(id){
        listview.currentIndex = id
    }

    ListView{
        id: listview
        width: root.width + 10
        height: root.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        model: ItemPathImageDetail{
            id: listImgPath
        }
        delegate: Item{
            width: 165
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: img
                anchors.centerIn: parent
                width: parent.width - 10
                height: width
                source: srcImgDetail
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                cache: true
            }
            Rectangle{
                id: line
                anchors.horizontalCenter: img.horizontalCenter
                anchors.top: img.bottom
                anchors.topMargin: 2
                width: img.width - 4
                height: 1
                color: "#000000"
                opacity: 0.1
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    listview.currentIndex = index
                    root.clickID(index)
                }
            }

        }

        highlight: Rectangle {
            width: 165
            height: 165
            color: "#000000"
            opacity: 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 2
        }
        highlightFollowsCurrentItem: true
        focus: true

    }
    layer.enabled: true
    layer.effect: OpacityMask{
        maskSource: Item{
            width: Properties.sizeImageView.width
            height: Properties.sizeImageView.height
            Rectangle{
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }
}
