import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0

Rectangle{
    property size sizeDisplay: Qt.size(1920, 1080)
    property size sizeHeader: Qt.size(0, 0)
    id: root
    width: sizeDisplay.width
    height: sizeDisplay.height
    color: "#ffffff"
    //    opacity: (sizeDisplay.width - x )/ sizeDisplay.width
    function updateData(){
        listImgPath.clear()
        timerAutoNextImage.restart()
        header.showBtnBack()
        for(var i = 0; i < Data.numImgDetail; i++){
            listImgPath.append({
                                   srcImgDetailFromJson: Data.listImgDetail[i]
                               });
        }

    }

    function backHome(){
        rootHide.start()
        root.enabled = false
        listImgPath.clear()
        header.hideBtnBack()
    }

    MouseArea{
        anchors.fill: parent
    }
    Rectangle{
        property var mouseXPrevious

        id: dragArea
        width: sizeDisplay.width
        height: sizeDisplay.height
        anchors.top: parent.top
        color: "transparent"
        MouseArea{
            anchors.fill: parent
            drag.target: root
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: sizeDisplay.width
            onPressed: {
                timerGetMousePrevious.start()
                timerGetMousePrevious.repeat = true
                timerGetMousePrevious.running = true
            }
            onReleased: {
                timerGetMousePrevious.stop()
                if(dragArea.mouseXPrevious < root.x){
                    backHome()
                }else{
                    rootShow.start()
                }
            }
        }
        Timer{
            id: timerGetMousePrevious
            interval: 10
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                dragArea.mouseXPrevious = root.x
            }
        }

        ParallelAnimation{
            id: rootHide
            NumberAnimation{
                target: root
                properties: "x"
                from: root.x
                to: sizeDisplay.width
                easing.type: Easing.InCubic
            }
        }
        ParallelAnimation{
            id: rootShow
            NumberAnimation{
                target: root
                properties: "x"
                from: root.x
                to: 0
                easing.type: Easing.InCubic
            }
        }
    }
    layer.enabled: true
    layer.effect: OpacityMask{
        maskSource: Item{
            width: sizeDisplay.width
            height: sizeDisplay.height
            Rectangle{
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }
    Rectangle{
        id: rectTextTitle
        anchors.left: root.left
        anchors.top: root.top
        width: sizeDisplay.width
        height: root.height -  rectContainImg.height - sizeHeader.height
        color: "#f5f6f7"

        //        LinearGradient{
        //            anchors.fill: parent
        //            start: Qt.point(0, 0)
        //            end: Qt.point(parent.width, parent.height)
        //            gradient: Gradient{
        //                GradientStop{position: 0.0; color: "#fdfbfb"}
        //                GradientStop{position: 1.0; color: "#ECEFF1"}
        //            }
        //        }

        Text{
            id: textTitle
            anchors.left: parent.left
            anchors.leftMargin: root.width / 48
            anchors.top: parent.top
            anchors.topMargin: root.height / 20
            //            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            wrapMode: Text.WordWrap
            font.pixelSize: root.height / 21
            font.weight: Font.Black
            //            font.family: "San Francisco"
            FontLoader { id: myCustomFont; source: "fonts/Lora-Bold.ttf" }
            font.family: myCustomFont.name
            //            color: "white"
            text: {
                if(Data.indexItem != -1)
                    Data.listTitle[Data.indexItem]
                else
                    ""
            }
        }


        RosButton{
            id: rectPresentation
            anchors.left: rectTextTitle.left
            anchors.leftMargin: root.width / 45
            anchors.bottom: rectTextTitle.bottom
            anchors.bottomMargin: root.height / 54
            height: root.height / 15
            img_src: "present"
            textIn: "Thuyết trình"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    RosIntegration.presentObject(Data.indexItem)
                }
            }

        }
        RosButton{
            id: rectGuide
            anchors.left: rectPresentation.right
            anchors.leftMargin: 50
            anchors.verticalCenter: rectPresentation.verticalCenter
            width: rectPresentation.width
            height: rectPresentation.height
            img_src: "guide"
            color: "#009688"
            textIn: "Chỉ đường"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    RosIntegration.leadToObject(Data.indexItem)
                }
            }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 0.3
            samples: 25
            radius: 5
            color: "#7f8c8d"
        }
    }



    Rectangle{
        id: rectContainImg
        anchors.left: root.left
        anchors.top: rectTextTitle.bottom
        //        anchors.topMargin: 10
        width: root.width / 1.371428571
        height: sizeDisplay.height / (root.width / width)
        color: rectTextDetail.color
        Rectangle {
            id: rectContainPath
            width: parent.width
            height: parent.height
            PathView {
                id: view
                anchors.fill: parent
                model: ItemPathImageDetail{
                    id: listImgPath
                }

                pathItemCount: Data.numImgDetail
                //                pathItemCount: 2
                path: Path {
                    startX: -rectContainPath.width / 2
                    startY: view.height / 2

                    PathLine {
                        x: rectContainPath.width * Data.numImgDetail - rectContainPath.width / 2
                        y: view.height / 2
                    }

                }
                delegate: Rectangle {
                    width: rectContainPath.width
                    height: rectContainPath.height
                    color: rectContainImg.color
                    Image {
                        id: imgDetailPath
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: srcImgDetailFromJson
                    }
                }
                onCurrentIndexChanged: {
                    //                    console.log("root: current index image in detail change")
                    timerAutoNextImage.restart()
                }
            }
            Timer{
                id: timerAutoNextImage
                interval: 5000
                repeat: true
                running: false
                onTriggered: {
                    view.incrementCurrentIndex()
                }
            }
        }
    }


    Rectangle{
        id: rectTextDetail
        anchors.left: rectContainImg.right
        anchors.top: rectTextTitle.bottom
        //        anchors.topMargin: 5
        width: sizeDisplay.width - rectContainImg.width
        height: sizeDisplay.height
        color: "#ffffff"
        radius: 0

        Text {
            id: textDetail
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            width: parent.width - 20
            wrapMode: Text.WordWrap
            font.weight: Font.Normal
            font.pixelSize: 14
            FontLoader { id: myCustomFontDetail; source: "fonts/Merriweather-Regular.ttf" }
            font.family: myCustomFontDetail.name
            text: "<b></b> " + Data.textDetail
        }


//        layer.enabled: true
//        layer.effect: InnerShadow {
//            horizontalOffset: -0.3
//            samples: 25
//            radius: 5
//            color: "#7f8c8d"
//        }
    }

}
