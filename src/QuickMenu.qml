import QtQuick 2.0

Rectangle {
    id: quickMenu
    property int timeOpenClose: 500
    color: "#fafafa"
    signal opened()
    signal closed()
    function open(){
        animationOpen.start()
        quickMenu.opened()
    }

    function close(){
        animationClose.start()
        quickMenu.closed()
    }
    RosMap{
        anchors.fill: parent
        anchors.centerIn: parent
    }

    NumberAnimation {
        id: animationOpen
        target: quickMenu
        property: "opacity"
        duration: timeOpenClose
        from: 0
        to: 1
        easing.type: Easing.InOutQuad
    }
    NumberAnimation {
        id: animationClose
        target: quickMenu
        property: "opacity"
        duration: timeOpenClose
        from: 1
        to: 0
        easing.type: Easing.InOutQuad
    }
}
