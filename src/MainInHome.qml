import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: Properties.sizeMain.width
    height: Properties.sizeMain.height
    signal clickID(int id)
    Rectangle{
        id: mainHome
        anchors.fill: parent
        color: "#f3f5f6"
        Rectangle {
            width: parent.width
            height: parent.height
            opacity: 0
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#C3CFE2" }
                GradientStop { position: 1.0; color: "#cfd8dc" }
            }
            layer.enabled: true
            layer.effect: InnerShadow{
                verticalOffset: 1
                samples: 5
                radius: 1
            }
        }
        GridView{
            id: listItem
            anchors.topMargin: Properties.sizeDisplay.height / 22.2
            anchors.leftMargin: Properties.sizeDisplay.width / 32
            anchors.fill: parent
            // cellWidth: 464 = 1920 / 4,137931034
            cellWidth: 345 + 40
            //        cellHeight: 480
            cellHeight: 300 + 36
            flow: GridView.FlowTopToBottom
            model: ItemModel{}
            snapMode: ListView.SnapOneItem
            delegate: Rectangle{
                width: 345
                height: 336 - 30
                radius: 5
                color: "white"
                Image {
                    id: imgThumbnail
                    width: parent.width
                    height: parent.height - parent.width / 8
                    asynchronous: true
                    source: srcThum

                    layer.enabled: true
                    layer.effect: OpacityMask{
                        maskSource: Item{
                            width: imgThumbnail.width
                            height: imgThumbnail.height
                            Rectangle{
                                anchors.centerIn: parent
                                width: parent.width
                                height: parent.height
                                radius: 5
                            }
                        }
                    }
                }

                Rectangle{
                    id: rectOverrideImg
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.width / 8
                    width: parent.width
                    height: 20
                    color: parent.color
                }
                Rectangle{
                    id: rectTextTitle
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: parent.height / 6
                    color: "transparent"
                    Text{
                        //                        horizontalAlignment: Text.AlignHCenter
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        width: parent.width - 10
                        elide: Text.ElideRight
                        //                        FontLoader { id: myCustomFont; source: "fonts/Lora-Regular.ttf" }
                        font.family: "lato"
                        font.pixelSize: parent.height / 3
                        text: title
                    }
                }
                layer.enabled: true
                layer.effect: DropShadow{
                    verticalOffset: 0.1
                    horizontalOffset: 0.1
                    samples: 5
                    radius: 1
                    color: "#7f8c8d"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //                        console.log(index)
                        Data.setIndexItem(index)
                        clickID(index)
                        console.log(index)
                        //                        detailItem.visible = true
                        //                        detailItem.enabled = true
                        //                        detailItem.updateData()
                        //                        detailItemShow.start()
                    }
                }
            }

            //            ParallelAnimation{
            //                id: detailItemShow
            //                NumberAnimation{
            //                    target: detailItem
            //                    properties: "x"
            //                    from: sizeDisplay.width
            //                    to: 0
            //                    easing.type: Easing.OutCubic
            //                    duration: 800
            //                }
            //            }
        }

        //        DetailItem{
        //            id: detailItem
        //            sizeDisplay: Qt.size(window.width, window.height)
        //            sizeHeader: Qt.size(window.width, heightHeader)
        //            anchors.top: window.top
        //            anchors.left: window.left
        //            y:0
        //            x: window.width
        //        }
    }
}
