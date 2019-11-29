import QtQuick 2.0

Item {
    id: root
    anchors.centerIn: parent
    property var sizeMap: Qt.size(384, 384)
    property var sourceMap: "img/map/map.pgm"
    property var scaleRatio: 1
    property var scaleRatioMin: 0.1
    property var scaleRatioMax: 100
    property var scaleThreshold: 0.5
    property var rotateAngle: 0
    property var rotateDegree: 1
    Flickable {
        id: flick
        anchors.centerIn: parent
        width: sizeMap.width
        height: sizeMap.height
        contentWidth: sizeMap.width
        contentHeight: sizeMap.height
        PinchArea {
            width: Math.max(flick.contentWidth, flick.width)
            height: Math.max(flick.contentHeight, flick.height)

            property real initialWidth
            property real initialHeight
            onPinchStarted: {
                initialWidth = flick.contentWidth
                initialHeight = flick.contentHeight
            }

            onPinchUpdated: {
                // adjust content pos due to drag
                flick.contentX += pinch.previousCenter.x - pinch.center.x
                flick.contentY += pinch.previousCenter.y - pinch.center.y

                // resize content
                flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
            }

            onPinchFinished: {
                // Move its content within bounds.
                flick.returnToBounds()
            }

            Item {
                id: map
                anchors.centerIn: parent
                width: flick.contentWidth
                height: flick.contentHeight

                Image {
                    id: mapBack
                    source: sourceMap
                    anchors.fill: parent
                    smooth: false

                    function reload(){
                        source = ""
                        source = sourceMap
                    }
                    Timer{
                        interval: 500
                        running: true
                        repeat: true
                        triggeredOnStart: true
                        onTriggered: {
                            mapBack.reload()
                        }
                    }

                }

                Item {
                    id: centerRobot
                    x: RosIntegration.robotCoordinates.x
                    y: RosIntegration.robotCoordinates.y
                }
                Image {
                    id: robot
                    source: "img/default.png"
                    width: 10
                    height: 10
                    anchors.centerIn: centerRobot
                }
                Timer{
                    id: timerRequestDrawPath
                    interval: 1000
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: {
                        if(RosIntegration.navPath_x.length > 0){
                            canvas.requestPaint()
                        }
                    }
                }

                Canvas{
                    id: canvas
                    width: 300
                    height: width

                    onPaint: {
                        // get drawing context
                        var context = getContext("2d")

                        // clear canvas
                        context.beginPath()
                        context.clearRect(0, 0, width, height)
                        context.fill()

                        //                // fill inside with blue, leaving 10 pixel border
                        //                context.beginPath()
                        //                context.fillStyle = "blue"
                        //                context.fillRect(10, 10, width - 20, height - 20)
                        //                context.fill()
                        // Draw a line
                        //                context.beginPath();
                        //                context.lineWidth = 2;
                        //                context.moveTo(30, 30);
                        //                context.strokeStyle = "red"
                        //                context.lineTo(width-30, height-30);
                        //                context.stroke();
                        // Draw a path
                        context.beginPath()
                        context.lineWidth = 2
                        console.log("abc" + RosIntegration.navPath_x.length)
                        var startX = RosIntegration.navPath_x[0]
                        var startY = RosIntegration.navPath_y[0]
                        context.moveTo(startX, startY)
                        context.strokeStyle = "red"
                        context.imageSmoothingEnabled = false
                        for(var i = 0; i < RosIntegration.navPath_x.length; i++){
                            var nextX = RosIntegration.navPath_x[i]
                            var nextY = RosIntegration.navPath_y[i]
                            context.lineTo(nextX, nextY)
                        }
                        context.stroke()
                        // Draw a circle
                        //                context.beginPath();
                        //                context.fillStyle = "orange"
                        //                context.strokeStyle = "red"
                        //                context.moveTo(width/2+60, height/2);
                        //                context.arc(width/2, height/2, 60, 0, 2*Math.PI, true)
                        //                context.fill();
                        //                context.stroke();

                        // Draw some text
                        //                context.beginPath();
                        //                context.strokeStyle = "lime green"
                        //                context.font = "20px sans-serif";
                        //                context.text("Hello, world!", width/2, 50);
                        //                context.stroke();
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onDoubleClicked: {
                        flick.contentWidth = sizeMap.width
                        flick.contentHeight = sizeMap.height
                    }

                    onWheel: {
                        //zoom
                        if (wheel.angleDelta.y > 0){
                            scaleRatio += scaleThreshold
                            if(scaleRatio > scaleRatioMax){
                                scaleRatio = scaleRatioMax
                            }
                        }else{
                            scaleRatio -= scaleThreshold
                            if(scaleRatio < scaleRatioMin){
                                scaleRatio = scaleRatioMin
                            }
                        }
                        map.scale = scaleRatio
                        ////            rotate
                        //            if(wheel.angleDelta.y > 0){
                        //                rotateAngle += rotateDegree
                        //            }else{
                        //                rotateAngle -= rotateDegree
                        //            }
                        //            map.rotation = rotateAngle
                    }

                }

            }
        }
    }


}
//Rectangle {
//    width: 384
//    height: 384
//    color: "gray"
//    Flickable {
//        id: flick
//        anchors.fill: parent
//        contentWidth: 384
//        contentHeight: 384
//        PinchArea {
//            width: Math.max(flick.contentWidth, flick.width)
//            height: Math.max(flick.contentHeight, flick.height)

//            property real initialWidth
//            property real initialHeight
//            onPinchStarted: {
//                initialWidth = flick.contentWidth
//                initialHeight = flick.contentHeight
//            }

//            onPinchUpdated: {
//                // adjust content pos due to drag
//                flick.contentX += pinch.previousCenter.x - pinch.center.x
//                flick.contentY += pinch.previousCenter.y - pinch.center.y

//                // resize content
//                flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
//            }

//            onPinchFinished: {
//                // Move its content within bounds.
//                flick.returnToBounds()
//            }

//            Rectangle {
//                width: flick.contentWidth
//                height: flick.contentHeight
//                color: "white"
//                Image {
//                    anchors.fill: parent
//                    source: "img/map/map.pgm"
//                    smooth: false
//                    MouseArea {
//                        anchors.fill: parent
//                        onDoubleClicked: {
//                            flick.contentWidth = 500
//                            flick.contentHeight = 500
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
