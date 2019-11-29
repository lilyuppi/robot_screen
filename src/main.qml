import QtQuick 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
//import Qt.labs.controls.material 1.0


Window {
    id: window
    property size sizeDisplay: Qt.size(1920, 1080)
    property int heightHeader: 40
    //    visibility: "FullScreen"
    //    width: sizeDisplay.width
    //    height: sizeDisplay.height
    width: Properties.sizeDisplay.width
    height: Properties.sizeDisplay.height
    visible: true
    //    color: "#e9ebee"
    color: "#f3f5f6"
    //    Loader{
    //        id: loader
    //        anchors.fill: parent
    //        source: "MainInHome.qml"
    //        onStatusChanged: if (loader.status == Loader.Ready) console.log('Loaded')
    //    }
    Loader{
        id: loaderMain
        anchors.left: loaderNavigationBar.right
        anchors.top: loaderHeader.bottom
        source: "MainInHome.qml"
        onSourceChanged: animMain.running = true
        NumberAnimation{
            id: animMain
            target: loaderMain.item
            property: "opacity"
            from: 0
            to: 1
            duration: 500
            easing.type: Easing.InSine
        }
        Connections{
            id: connectMain
            target: loaderMain.item
            ignoreUnknownSignals: true
            onClickID: { // on click item in home
                //console.log(id)
                loaderMain.setSource("DetailItemInHome.qml", {"index" : id})
                loaderHeader.setSource("Header.qml", {"state" : "inDetailItemInHome"})
            }


        }
    }

    Loader{
        id: loaderHeader
        anchors.left: loaderNavigationBar.right
        anchors.top: parent.top
        source: "Header.qml"

    }

    Loader{
        id: loaderNavigationBar
        anchors.left: parent.left
        anchors.top: parent.top
        source: "NavigationBarLeft.qml"
        Connections{
            target: loaderNavigationBar.item
            onClickInNav: {
                switch(id){
                case "home":
                    loaderMain.source = "MainInHome.qml"
                    loaderHeader.setSource("Header.qml", {"state" : "inHome"})
                    break
                case "school":
                    loaderMain.source = "MainInSchool.qml"
                    loaderHeader.setSource("Header.qml", {"state" : "inSchool"})
                    break
                case "map":
                    loaderMain.source = "MainInMap.qml"
                    loaderHeader.setSource("Header.qml", {"state" : "inMap"})
                    break
                }
                console.log(id)
            }
        }
    }
}
