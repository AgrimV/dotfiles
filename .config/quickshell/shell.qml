import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

ShellRoot {

    PanelWindow {
        color: "black"
        visible: true

        anchors {
            top: true
            left: true
            bottom: true
        }

        margins {
            top: 5
            bottom: 5
        }

        implicitWidth: 30

        ColumnLayout {
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            Layout.fillWidth: true

            Column {
                spacing: 5

                Repeater {
                    model: hyprland.maxWorkspace || 1

                    Item {
                        required property int index
                        property bool is_active: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)
                        width: 25
                        height: 25
                        Rectangle {
                            visible: is_active
                            radius: 3
                            anchors.fill: parent
                            color: is_active ? "#4fa3fd" : "black"
                            anchors.centerIn: workspaceText
                        }
                        Text {
                            id: workspaceText
                            anchors.centerIn: parent
                            text: (index + 1).toString()
                            color: is_active ? "black" : "#4fa3fd"
                        }
                    }
                }
            }
        }

        ColumnLayout {
            anchors.centerIn: parent

            spacing: 5

            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }

            Text {
                text: Qt.formatDateTime(clock.date, "d")
                color: "#4fa3fd"
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: Qt.formatDateTime(clock.date, "M")
                color: "#4fa3fd"
            }

            Text {
                text: Qt.formatDateTime(clock.date, "yy")
                color: "#4fa3fd"
            }

            Item {
                implicitHeight: 20
            }

            Text {
                Layout.alignment: Qt.AlignRight
                text: Qt.formatDateTime(clock.date, "h")
                color: "#4fa3fd"
            }

            Text {
                text: Qt.formatDateTime(clock.date, "m")
                color: "#4fa3fd"
            }
        }

        ColumnLayout {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 5

            // Text {
            //     text: "bot"
            //     color: "#4fa3fd"
            // }
        }
    }

    component VerticalBarSeparator: Rectangle {

        Layout.topMargin: 10
        Layout.bottomMargin: 10
        Layout.fillWidth: true
        implicitHeight: 1
        color: "white"
    }

    Singleton {
        id: hyprland

        property list<HyprlandWorkspace> workspaces: sortWorkspaces(Hyprland.workspaces.values)
        property int maxWorkspace: findMaxId()

        function sortWorkspaces(ws) {
            return [...ws].sort((a, b) => a?.id - b?.id);
        }

        function switchWorkspace(w: int): void {
            Hyprland.dispatch(`workspace ${w}`);
        }

        function findMaxId(): int {
            if (hyprland.workspaces.length === 0) {
                return 1;
            }
            let num = hyprland.workspaces.length;
            let maxId = hyprland.workspaces[num - 1]?.id || 1;
            return maxId;
        }

        Connections {
            target: Hyprland
            function onRawEvent(event) {
                let eventName = event.name;

                switch (eventName) {
                case "createworkspacev2":
                    {
                        hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                        hyprland.maxWorkspace = findMaxId();
                    }
                case "destroyworkspacev2":
                    {
                        hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                        hyprland.maxWorkspace = findMaxId();
                    }
                }
            }
        }
    }
}
