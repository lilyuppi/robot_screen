import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
Rectangle{
    id: root
    width: Properties.sizeImageView.width
    height: Properties.sizeImageView.height
    color: "#ffffff"
    property int numItem: Data.numImgDetail

    signal newID(int id)


    function updateHighlight(id){
        view.currentIndex = id
    }



    Rectangle {
        id: rectContainPath
        width: parent.width
        height: parent.height
        color: root.color
        PathView {
            id: view
            anchors.fill: parent
            model: ItemPathImageDetail{
                id: listImgPath
            }

            pathItemCount: numItem
//                pathItemCount: 2
            path: Path {
                startX: rectContainPath.width / 2
                startY: view.height / 2

                PathLine {
                    x: rectContainPath.width * numItem + rectContainPath.width / 2
                    y: view.height / 2
                }

            }
            delegate: Rectangle {
                width: rectContainPath.width
                height: rectContainPath.height
                color: root.color
                Image {
                    id: imgDetailPath
                    width: parent.width
                    height: parent.height                    
                    fillMode: Image.PreserveAspectFit
                    source: srcImgDetail
                }                              
            }
            onCurrentIndexChanged: {
                //                    console.log("root: current index image in detail change")
                timerAutoNextImage.restart()
                root.newID(view.currentIndex)
            }
        }
        Timer{
            id: timerAutoNextImage
            interval: 5000
            repeat: true
            running: true
            onTriggered: {
                view.incrementCurrentIndex()
            }
        }

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

