// 
// Qml Colors
// Generated with Matugen
pragma Singleton

import QtQuick

QtObject {
<* for name, value in colors *>
    readonly property color {{name}}: "{{value.default.hex}}"
<* endfor *>
}
