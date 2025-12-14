import QtQuick
import Quickshell

PanelWindow {
    id: root

    required property var modelData

    property list<Item> topItems
    property list<Item> midItems
    property list<Item> botItems

    property int barWidth: Globals.controls.barWidth

    anchors {
        top: true
        left: true
        bottom: true
    }

    margins {
        top: 2
        bottom: 2
    }

    screen: modelData
    implicitWidth: barWidth
    color: "transparent"

    Rectangle {

            color: Theme.background

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            height: childrenRect.height + 4
            width: barWidth - 4

            radius: Globals.controls.radius

        Column {
            id: top
            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }
            spacing: Globals.controls.spacing
        }
    }

    Rectangle {

            color: Theme.background

            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }

            height: childrenRect.height + 4
            width: barWidth - 4

            radius: Globals.controls.radius

        Column {
            id: mid
            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }
            spacing: Globals.controls.spacing
        }
    }

    Rectangle {

            color: Theme.background

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            height: childrenRect.height + 4
            width: barWidth - 4

            radius: Globals.controls.radius

        Column {
            id: bot
            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }
            spacing: Globals.controls.spacing
        }
    }

    Component.onCompleted: {
        for (var item of topItems) {
            item.parent = top;
            item.anchors.horizontalCenter = top.verticalCenter;
        }
        for (var item of midItems) {
            item.parent = mid;
            item.anchors.horizontalCenter = mid.verticalCenter;
        }
        for (var item of botItems) {
            item.parent = bot;
            item.anchors.horizontalCenter = bot.verticalCenter;
        }
    }
}
