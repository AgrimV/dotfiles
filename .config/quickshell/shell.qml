//@ pragma UseQApplication
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

ShellRoot {

    PanelWindow {
        color: "transparent"

        visible: true
        aboveWindows: false

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

        Rectangle {
            color: Theme.background

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            height: childrenRect.height + 4
            width: childrenRect.width + 4

            radius: 3

            Column {
                spacing: 5

                anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: hyprland.maxWorkspace

                    Rectangle {
                        required property int index
                        property bool is_active: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)
                        width: 20
                        height: 20
                        radius: 3

                        color: is_active ? Theme.primary : workspaceTextArea.pressed ? Theme.source_color : workspaceTextArea.containsMouse ? Theme.primary_container : Theme.background

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
                            color: is_active ? Theme.background : workspaceTextArea.pressed ? Theme.on_primary :Theme.on_background
                        }
                    }
                }
            }
        }

        Rectangle {

            color: clockArea.pressed ? Theme.source_color : clockArea.containsMouse ? Theme.primary_container : Theme.background

            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter

            height: childrenRect.height + 4
            width: 24

            radius: 3

            MouseArea {
                id: clockArea
                anchors.fill: parent
                hoverEnabled: true
            }

            ColumnLayout {
                anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 5

                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "d")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: Qt.formatDateTime(clock.date, "M")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "yy")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                }

                Item {
                    height: 10
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: Qt.formatDateTime(clock.date, "h")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "m")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                }
            }
        }

        Rectangle {
            color: Theme.background

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            height: childrenRect.height + 4
            width: childrenRect.width + 4

            radius: 3

            Column {
                anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 5

                Repeater {
                    model: SystemTray.items.values

                    Rectangle {
                        id: sysTrayItem
                        required property SystemTrayItem modelData

                        anchors.horizontalCenter: parent.horizontalCenter

                        width: 20
                        height: 20
                        radius: 3

                        color: sysTrayItemArea.pressed ? Theme.source_color : sysTrayItemArea.containsMouse ? Theme.primary_container : Theme.background

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
                            hoverEnabled: true

                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

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

                Rectangle {
                    property bool is_caffed: false

                    color: is_caffed ? Theme.primary : caffeineArea.pressed ? Theme.source_color : caffeineArea.containsMouse ? Theme.primary_container : Theme.background

                    anchors.horizontalCenter: parent.horizontalCenter

                    implicitHeight: 20
                    implicitWidth: 20

                    radius: 3

                    MouseArea {
                        id: caffeineArea
                        anchors.fill: parent
                        hoverEnabled: true

                        acceptedButtons: Qt.LeftButton

                        onClicked: event => {
                            parent.is_caffed = !parent.is_caffed;

                            caf.running = true;

                            if (!parent.is_caffed)
                                decaf.running = true;
                        }
                    }

                    Process {
                        id: caf
                        running: false
                        command: ["killall", "hypridle"]
                    }

                    Process {
                        id: decaf
                        running: false
                        command: ["hyprctl", "dispatch", "exec", "hypridle"]
                    }

                    Text {
                        text: parent.is_caffed ? "󰅶" : "󰾪"
                        color: parent.is_caffed ? Theme.background : Theme.on_background

                        font.pointSize: 10

                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    color: systemPowerArea.pressed ? Theme.source_color : systemPowerArea.containsMouse ? Theme.primary_container : Theme.background

                    anchors.horizontalCenter: parent.horizontalCenter

                    implicitHeight: 20
                    implicitWidth: 20

                    radius: 3

                    MouseArea {
                        id: systemPowerArea
                        anchors.fill: parent
                        hoverEnabled: true

                        acceptedButtons: Qt.LeftButton

                        onClicked: event => {}
                    }

                    // QsMenu {}

                    Text {
                        text: ""
                        color: Theme.on_background

                        font.pointSize: 10

                        anchors.centerIn: parent
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
