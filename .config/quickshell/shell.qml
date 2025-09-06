import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

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
    }
}
