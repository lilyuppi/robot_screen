import QtQuick 2.0

Item {
    id: root
    property int durationExpand: 500
    width: Properties.sizeNavBar.width
    height: Properties.sizeNavBar.height
    z: 1
    state: "default"

    signal clickInNav(string id)

    function updateExpand(){
        if(root.state == "default"){
            root.state = "expanded"
        }else{
            root.state = "default"
        }

        btnHome.state = root.state
        btnSchool.state = root.state
        btnMap.state = root.state
    }

    function hideExpandAll(){
        root.state = "default"

        btnHome.state = root.state
        btnSchool.state = root.state
        btnMap.state = root.state
    }

    Image {
        id: bg
        z: 1
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "img/bgNav.png"
    }
    HoverNavLeft{
        anchors.fill: parent
        z: 2
    }

    ButtonNavBar{
        id: btnMenu
        z: 2
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        src: "img/menu.png"
        isMenu: true
        onClicked: {
//            console.log("menu clicked")
                root.updateExpand()
        }
    }
    ButtonNavBar{
        id: btnHome
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 150
        textInLine: "Phòng truyền thống"
        src: "img/btnHome.png"
        enableHoverClicked: true
        isSelected: true
        durationExpand: 500
        onClicked: {
            console.log("home")
            clickInNav("home")
            btnHome.updateHover(true)
            btnMap.updateHover(false)
            btnSchool.updateHover(false)
            hideExpandAll()
        }
    }
    ButtonNavBar{
        id: btnSchool
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 230
        textInLine: "Tổ chức"
        src: "img/btnSchool.png"
        enableHoverClicked: true
        isSelected: false
        durationExpand: 500
        onClicked: {
            console.log("school")
            clickInNav("school")
            btnSchool.updateHover(true)
            btnMap.updateHover(false)
            btnHome.updateHover(false)
            hideExpandAll()
        }
    }

    ButtonNavBar{
        id: btnMap
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 310
        textInLine: "Bản đồ"
        src: "img/btnMap.png"
        enableHoverClicked: true
        isSelected: false
        durationExpand: 500
        onClicked: {
            console.log("map")
            clickInNav("map")
            btnMap.updateHover(true)
            btnHome.updateHover(false)
            btnSchool.updateHover(false)
            hideExpandAll()
        }
    }

    states: [
        State {
            name: "default"
            PropertyChanges {
                target: root
                width: Properties.sizeNavBar.width
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: root
                width: Properties.sizeNavBarExpand.width
            }
        }
    ]
    transitions: [
        Transition{
            from: "default"
            to: "expanded"
            NumberAnimation{
                target: root
                property: "width"
                duration: durationExpand
                easing.type: Easing.OutSine
            }
        },
        Transition{
            from: "expanded"
            to: "default"
            NumberAnimation{
                target: root
                property: "width"
                duration: durationExpand
                easing.type: Easing.InSine
            }
        }
    ]
}
