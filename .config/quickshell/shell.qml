//@ pragma UseQApplication
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

ShellRoot {

    PanelWindow {
        color: "transparent"
        // color: "#000000"

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
                    model: hyprland.maxWorkspace

                    Rectangle {
                        required property int index
                        property bool is_active: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)
                        width: 25
                        height: 25
                        radius: 3

                        color: is_active ? "#4fa3fd" : workspaceTextArea.containsMouse ? "#191919" : "#000000"

                        MouseArea {
                            id: workspaceTextArea

                            anchors.fill: parent
                            onClicked: function () {
                                hyprland.switchWorkspace(parent.index + 1);
                            }

                            hoverEnabled: true
                        }

                        Text {
                            id: workspaceText
                            anchors.centerIn: parent
                            text: index + 1
                            color: is_active ? "#000000" : "#4fa3fd"
                        }
                    }
                }
            }
        }

        Rectangle {

            color: clockArea.pressed ? "#4fa3fd" : clockArea.containsMouse ? "#191919" : "#000000"
            anchors.centerIn: parent

            implicitHeight: 150
            width: 25
            radius: 3

            MouseArea {
                id: clockArea
                anchors.fill: parent
                hoverEnabled: true
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
                    color: clockArea.pressed ? "#000000" : "#4fa3fd"
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: Qt.formatDateTime(clock.date, "M")
                    color: clockArea.pressed ? "#000000" : "#4fa3fd"
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "yy")
                    color: clockArea.pressed ? "#000000" : "#4fa3fd"
                }

                Item {
                    implicitHeight: 20
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: Qt.formatDateTime(clock.date, "h")
                    color: clockArea.pressed ? "#000000" : "#4fa3fd"
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "m")
                    color: clockArea.pressed ? "#000000" : "#4fa3fd"
                }
            }
        }

        ColumnLayout {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            Layout.fillWidth: true

            Column {

                spacing: 5

                Repeater {
                    model: SystemTray.items.values

                    Rectangle {
                        id: sysTrayItem
                        required property SystemTrayItem modelData

                        width: 25
                        height: 25
                        radius: 3

                        color: sysTrayItemArea.pressed ? "#4fa3fd" : sysTrayItemArea.containsMouse ? "#191919" : "#000000"

                        IconImage {
                            id: icon
                            anchors.centerIn: parent
                            source: sysTrayItem.modelData.icon
                            implicitSize: 17
                        }

                        QsMenuAnchor {
                            id: menuAnchor
                            menu: sysTrayItem.modelData.menu

                            anchor.window: sysTrayItem.QsWindow.window

                            anchor.onAnchoring: {
                                const window = sysTrayItem.QsWindow.window;
                                const widgetRect = window.contentItem.mapFromItem(sysTrayItem, 0, sysTrayItem.height, sysTrayItem.width, sysTrayItem.height);

                                menuAnchor.anchor.rect = widgetRect;
                            }
                        }

                        MouseArea {
                            id: sysTrayItemArea
                            anchors.fill: parent

                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                            hoverEnabled: true

                            onClicked: event => {
                                menuAnchor.open();
                            // if (event.button == Qt.LeftButton) {
                            //     sysTrayItem.modelData.activate();
                            // } else if (event.button == Qt.MiddleButton) {
                            //     sysTrayItem.modelData.secondaryActivate();
                            // } else if (event.button == Qt.RightButton) {
                            //     menuAnchor.open();
                            // }
                            }
                        }
                    }
                }
            }
        }
    }

    Singleton {
        id: hyprland

        property list<HyprlandWorkspace> workspaces: sortWorkspaces(Hyprland.workspaces.values)
        property int maxWorkspace: findMaxId()

        function sortWorkspaces(ws) {
            return [...ws].sort((a, b) => a?.id - b?.id);
        }

        function switchWorkspace(w: int): void {
            if (w != Hyprland.focusedMonitor?.activeWorkspace?.id)
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
                        hyprland.maxWorkspace = hyprland.findMaxId();
                    }
                case "destroyworkspacev2":
                    {
                        hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                        hyprland.maxWorkspace = hyprland.findMaxId();
                    }
                }
            }
        }
    }
}
