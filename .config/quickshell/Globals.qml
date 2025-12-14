pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

	readonly property var controls: QtObject {
		readonly property int spacing: 8
		readonly property int radius: 3
		readonly property int barWidth: 30
		readonly property int iconSize: 17
	}

	readonly property var font: QtObject {
		readonly property font regular: Qt.font({
			family: "FiraMono Nerd Font",
			pointSize: 11
		})
		readonly property font bold: Qt.font({
			family: "FiraMono Nerd Font",
			pointSize: 11,
			weight: 800
		})
		readonly property font italic: Qt.font({
			family: "FiraMono Nerd Font",
			pointSize: 11,
			italic: true
		})
		readonly property font mono: Qt.font({
			family: "FiraMono Nerd Font Mono",
			pointSize: 11
		})
		readonly property font small: Qt.font({
			family: "FiraMono Nerd Font",
			pointSize: 8
		})
		readonly property font smallbold: Qt.font({
			family: "FiraMono Nerd Font",
			pointSize: 8,
			weight: 800
		})
		readonly property font smallitalic: Qt.font({
			family: "FiraMono Nerd Font",
			pointSize: 8,
			italic: true
		})
		readonly property font smallmono: Qt.font({
			family: "FiraMono Nerd Font Mono",
			pointSize: 8,
		})
	}
}
