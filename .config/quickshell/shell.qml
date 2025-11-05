//@ pragma UseQApplication
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower 
import Quickshell.Services.Pipewire

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
            width: 24

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
                            font.pointSize: 11
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
                    font.pointSize: 11
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: Qt.formatDateTime(clock.date, "M")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                    font.pointSize: 11
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "yy")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                    font.pointSize: 11
                }

                Item {
                    height: 10
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: Qt.formatDateTime(clock.date, "h")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                    font.pointSize: 11
                }

                Text {
                    text: Qt.formatDateTime(clock.date, "m")
                    color: clockArea.pressed ? Theme.on_primary : Theme.on_background
                    font.pointSize: 11
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
            width: 24

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
                                const widgetRect = window.contentItem.mapFromItem(sysTrayItem, 25, 0);

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

                    height: 20
                    width: 20

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

                        font.pointSize: 11

                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    readonly property UPowerDevice device: UPower.displayDevice
                    readonly property bool batteryAvailable: device && device.ready && device.isLaptopBattery
                    readonly property real batteryLevel: batteryAvailable ? Math.round(device.percentage * 100) : 0
                    readonly property bool isCharging: batteryAvailable && device.state === UPowerDeviceState.Charging && device.changeRate > 0
                    readonly property bool isPluggedIn: batteryAvailable && (device.state !== UPowerDeviceState.Discharging && device.state !== UPowerDeviceState.Empty)
                    readonly property bool isLowBattery: batteryAvailable && batteryLevel <= 20
                    readonly property string batteryHealth: {
                        if (!batteryAvailable) {
                            return "N/A"
                        }

                        if (device.healthSupported && device.healthPercentage > 0) {
                            return `${Math.round(device.healthPercentage)}%`
                        }

                        if (device.energyCapacity > 0 && device.energy > 0) {
                            const healthPercent = (device.energyCapacity / 90.0045) * 100
                            return `${Math.round(healthPercent)}%`
                        }

                        return "N/A"
                    }
                    readonly property real batteryCapacity: batteryAvailable && device.energyCapacity > 0 ? device.energyCapacity : 0
                    readonly property string batteryStatus: {
                        if (!batteryAvailable) {
                            return "No Battery"
                        }

                        if (device.state === UPowerDeviceState.Charging && device.changeRate <= 0) {
                            return "Plugged In"
                        }

                        return UPowerDeviceState.toString(device.state)
                    }
                    readonly property bool suggestPowerSaver: batteryAvailable && isLowBattery && UPower.onBattery && (typeof PowerProfiles !== "undefined" && PowerProfiles.profile !== PowerProfile.PowerSaver)

                    readonly property var bluetoothDevices: {
                        const btDevices = []
                        const bluetoothTypes = [UPowerDeviceType.BluetoothGeneric, UPowerDeviceType.Headphones, UPowerDeviceType.Headset, UPowerDeviceType.Keyboard, UPowerDeviceType.Mouse, UPowerDeviceType.Speakers]

                        for (var i = 0; i < UPower.devices.count; i++) {
                            const dev = UPower.devices.get(i)
                            if (dev && dev.ready && bluetoothTypes.includes(dev.type)) {
                                btDevices.push({
                                                   "name": dev.model || UPowerDeviceType.toString(dev.type),
                                                   "percentage": Math.round(dev.percentage),
                                                   "type": dev.type
                                               })
                            }
                        }
                        return btDevices
                    }

                    function formatTimeRemaining() {
                        if (!batteryAvailable) {
                            return "Unknown"
                        }

                        const timeSeconds = isCharging ? device.timeToFull : device.timeToEmpty

                        if (!timeSeconds || timeSeconds <= 0 || timeSeconds > 86400) {
                            return "Unknown"
                        }

                        const hours = Math.floor(timeSeconds / 3600)
                        const minutes = Math.floor((timeSeconds % 3600) / 60)

                        if (hours > 0) {
                            return `${hours}h ${minutes}m`
                        }

                        return `${minutes}m`
                    }

                    color: systemPowerArea.pressed ? Theme.source_color : systemPowerArea.containsMouse ? Theme.primary_container : Theme.background

                    anchors.horizontalCenter: parent.horizontalCenter

                    height: 20
                    width: 20

                    radius: 3

                    MouseArea {
                        id: systemPowerArea
                        anchors.fill: parent
                        hoverEnabled: true

                        acceptedButtons: Qt.LeftButton

                        onClicked: event => {
                        }
                    }

                    Text {
                        text: ""
                        color: Theme.on_background

                        font.pointSize: 11

                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    color: systemSessionArea.pressed ? Theme.source_color : systemSessionArea.containsMouse ? Theme.primary_container : Theme.background

                    anchors.horizontalCenter: parent.horizontalCenter

                    height: 20
                    width: 20

                    radius: 3

                    MouseArea {
                        id: systemSessionArea
                        anchors.fill: parent
                        hoverEnabled: true

                        acceptedButtons: Qt.LeftButton

                        onClicked: event => {
                            wlogoutProcess.running = true;
                        }
                    }

                    Process {
                        id: wlogoutProcess
                        running: false
                        command: ["wlogout", "-b", "1", "-r", "0", "-L", "0", "-R", "1850", "-T", "325", "-B", "325"]
                    }

                    Text {
                        text: ""
                        color: Theme.on_background

                        font.pointSize: 11

                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

    Scope {
        id: root

        readonly property list<var> warnLevels: [...Config.general.battery.warnLevels].sort((a, b) => b.level - a.level)

        Connections {
            target: UPower

            function onOnBatteryChanged(): void {
                if (UPower.onBattery) {
                    if (Config.utilities.toasts.chargingChanged)
                        Toaster.toast(qsTr("Charger unplugged"), qsTr("Battery is now on AC"), "power_off");
                } else {
                    if (Config.utilities.toasts.chargingChanged)
                        Toaster.toast(qsTr("Charger plugged in"), qsTr("Battery is charging"), "power");
                    for (const level of root.warnLevels)
                        level.warned = false;
                }
            }
        }

        Connections {
            target: UPower.displayDevice

            function onPercentageChanged(): void {
                if (!UPower.onBattery)
                    return;

                const p = UPower.displayDevice.percentage * 100;
                for (const level of root.warnLevels) {
                    if (p <= level.level && !level.warned) {
                        level.warned = true;
                        Toaster.toast(level.title ?? qsTr("Battery warning"), level.message ?? qsTr("Battery level is low"), level.icon ?? "battery_android_alert", level.critical ? Toast.Error : Toast.Warning);
                    }
                }

                if (!hibernateTimer.running && p <= Config.general.battery.criticalLevel) {
                    Toaster.toast(qsTr("Hibernating in 5 seconds"), qsTr("Hibernating to prevent data loss"), "battery_android_alert", Toast.Error);
                    hibernateTimer.start();
                }
            }
        }

        Timer {
            id: hibernateTimer

            interval: 5000
            onTriggered: Quickshell.execDetached(["systemctl", "hibernate"])
        }
    }

    Scope {
        id: volumeOsd

        PwObjectTracker {
            objects: [ Pipewire.defaultAudioSink ]
        }

        Connections {
            target: Pipewire.defaultAudioSink?.audio

            function onVolumeChanged() {
                if (volumeOsd.first_load) {
                    volumeOsd.first_load = false;
                    return;
                }

                volumeOsd.show = true;
                hideTimer.restart();

                volumeOsd.is_muted = (Pipewire.defaultAudioSink?.audio.muted || Pipewire.defaultAudioSink?.audio.volume == 0) ? true : false;
            }

            function onMutedChanged() {
                volumeOsd.show = true;
                hideTimer.restart();

                volumeOsd.is_muted = Pipewire.defaultAudioSink?.audio.muted;
            }
        }

        property bool show: false
        property bool is_muted: false
        property bool first_load: true

        Timer {
            id: hideTimer
            running: false
            interval: 1500
            onTriggered: volumeOsd.show = false
        }

        LazyLoader {
            active: volumeOsd.show

            PanelWindow {
                anchors.bottom: true
                margins.bottom: screen.height / 10
                exclusiveZone: 0

                implicitWidth: 300
                implicitHeight: 25
                color: "transparent"

                // An empty click mask prevents the window from blocking mouse events.
                mask: Region {}

                Rectangle {
                    anchors.fill: parent
                    radius: 3
                    color: Theme.background

                    Text {
                        id: volumeText

                        text: volumeOsd.is_muted ? "" : Pipewire.defaultAudioSink?.audio.volume > 0.6 ? "" : ""
                        font.pointSize: 11

                        color: Theme.source_color

                        Layout.alignment: Qt.AlignLeft

                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }


                    Rectangle {
                        Layout.alignment: Qt.AlignRight

                        anchors.right: parent.right
                        anchors.left: volumeText.right
                        anchors.leftMargin: 10

                        implicitHeight: 20
                        radius: 3
                        color: Theme.primary_container

                        Rectangle {
                            color: volumeOsd.is_muted ? Theme.primary_container : Theme.primary

                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom

                                leftMargin: 3
                                topMargin: 3
                                bottomMargin: 3
                                rightMargin: 3
                            }

                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0) - 7
                            radius: parent.radius
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
