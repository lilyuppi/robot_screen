import QtQuick 2.0

Item {
    id: root
    width: Properties.sizeHeader.width
    height: Properties.sizeHeader.height
    property string txtHome: "Phòng truyền thống"
    property string txtSchool: "Tổ chức"
    property string txtMap: "Bản đồ"
    state: "inHome"
    function setTitle(title){
        txtTextTitle.text = title
    }

    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
    }
    Rectangle{
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        width: parent.width
        height: 1
        color: "#000000"
        opacity: 0.24
    }
    Item {
        id: viewTextTitle
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        width: 800
        height: Properties.sizeHeader.height
        Text{
            id: txtTextTitle
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            text: txtHome
            font.pixelSize: 28
            font.weight: Font.Bold
            //            clip: true
            elide: Text.ElideRight
        }
    }

    Item {
        id: viewButton
        anchors.left: viewTextTitle.right
        anchors.leftMargin: 30
        anchors.verticalCenter: viewTextTitle.verticalCenter
        width: 335
        height: 40
        Item{
            id: groupButtonDetailHome
            anchors.fill: parent
            RosButton{
                id: btnPresent
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                img_src: "present"
                textIn: "Thuyết trình"
                color: "#2C3E50"
                onClick: RosIntegration.presentObject(Data.indexItem)
            }
            RosButton{
                id: btnGuide
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                img_src: "guide"
                textIn: "Chỉ đường"
                color: "#2980B9"
                onClick: RosIntegration.leadToObject(Data.indexItem)
            }
        }
    }

    Item{
        id: groupButtonInHome
        width: 335
        height: 40
        anchors.left: root.left
        anchors.leftMargin: 850
        anchors.verticalCenter: root.verticalCenter
        visible: false
        RosButton{
            id: rectPresentation
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 150
            height: 40
            img_src: "present"
            color: "#2C3E50"
            textIn: "Thuyết trình"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Present at" + Data.indexItem)
                    RosIntegration.presentObject(Data.indexItem)
                }
            }

        }
        RosButton{
            id: rectGuide
            anchors.left: rectPresentation.right
            anchors.leftMargin: 35
            anchors.verticalCenter: rectPresentation.verticalCenter
            width: rectPresentation.width
            height: rectPresentation.height
            img_src: "guide"
            color: "#2980B9"
            textIn: "Chỉ đường"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    RosIntegration.leadToObject(Data.indexItem)
                    console.log("Lead to" + Data.indexItem)
                }
            }
        }
    }

    states: [
        State {
            name: "inDetailItemInHome"
            onCompleted: {
                setTitle(Data.listTitle[Data.indexItem])
                groupButtonDetailHome.visible = true
                groupButtonInHome.visible = true
            }
        },
        State {
            name: "inHome"
            onCompleted: {
                setTitle(txtHome)
                groupButtonDetailHome.visible = false
                groupButtonInHome.visible = false
            }
        },
        State {
            name: "inSchool"
            onCompleted: {
                setTitle(txtSchool)
                groupButtonDetailHome.visible = false
                groupButtonInHome.visible = false
            }
        },
        State {
            name: "inMap"
            onCompleted: {
                setTitle(txtMap)
                groupButtonDetailHome.visible = false
                groupButtonInHome.visible = false
            }
        }
    ]
}
