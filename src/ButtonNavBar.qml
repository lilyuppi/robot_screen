import QtQuick 2.0

Item {
    id: root
    property string src
    property string textInLine
    property bool enableHoverClicked: false
    property bool isSelected: false
    property bool isMenu: false
    property int durationExpand
    signal clicked()
    width: Properties.sizeIconMenu
    height: width
    z: {
        if(isSelected){
            z = 2
        }else{
            z = 1
        }
    }
    state: "default"
    function updateHover(is){
        isSelected = is
        if(isSelected){
            root.z = 2
        }else{
            root.z = 1
        }
    }

    Item{
        id: bgText
        anchors.left: imgBg.left
        anchors.leftMargin: 22
        anchors.verticalCenter: imgBg.verticalCenter
        width: 225
        height: 40
        visible: !isMenu
        Rectangle{
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.2
            radius: 2
        }

        Text {
            id: txtText
            fontSizeMode: Text.Fit
            text: textInLine
            anchors.verticalCenter: bgText.verticalCenter
            anchors.left: bgText.left
            anchors.leftMargin: 33
            font.pixelSize: 20
            font.family: "lato"
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            color: "#ffffff"
            visible: bgText.visible
        }
    }

    Image {
        id: imgBg
        width: Properties.sizeIconMenu
        height: width
        source: root.src
    }


    MouseArea{
        anchors.fill: imgBg
        onClicked: {
//                        console.log(root.state)
            console.log(root.width)
            root.clicked()
        }
    }
    MouseArea{
        anchors.fill: bgText
        onClicked: {
//                        console.log(root.state)
            console.log(root.width)
            root.clicked()
        }
    }
    states: [
        State {
            name: "default"
            PropertyChanges {
                target: root
                width: Properties.sizeIconMenu
            }
            PropertyChanges {
                target: bgText
                width: 0
            }
            PropertyChanges {
                target: txtText
                opacity: 0
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: root
                width: Properties.sizeItemInNavExpand.width
            }
            PropertyChanges {
                target: bgText
                width: 225
            }
            PropertyChanges {
                target: txtText
                opacity: 1
            }
        }

    ]
    transitions: [
        Transition {
            from: "default"
            to: "expanded"
            SequentialAnimation{
                PauseAnimation {
                    duration: durationExpand / 2
                }
                ParallelAnimation{
                    NumberAnimation{
                        target: bgText
                        property: "width"
                        duration: durationExpand
                        easing.type: Easing.OutSine
                    }
                    NumberAnimation{
                        target: txtText
                        property: "opacity"
                        duration: durationExpand * 2
                        easing.type: Easing.OutSine
                    }
                }
            }
        },
        Transition {
            from: "expanded"
            to: "default"
            ParallelAnimation{
                NumberAnimation{
                    target: bgText
                    property: "width"
                    duration: durationExpand
                    easing.type: Easing.InSine
                }
                NumberAnimation{
                    target: txtText
                    property: "opacity"
                    duration: durationExpand / 2
                    easing.type: Easing.InSine
                }
            }
        }
    ]
}
