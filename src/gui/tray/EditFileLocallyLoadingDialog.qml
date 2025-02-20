import QtQuick 2.15
import QtQuick.Window 2.15
import Style 1.0
import com.nextcloud.desktopclient 1.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Window {
    id: root
    flags: Qt.Dialog | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    color: "transparent"

    width: 320
    height: contentLayout.implicitHeight

    property string fileName: ""

    readonly property real fontPixelSize: Style.topLinePixelSize * 1.5
    readonly property real iconWidth: fontPixelSize * 2

    Component.onCompleted: {
        Systray.forceWindowInit(root);
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
        root.show();
        root.raise();
        root.requestActivate();
    }

    Rectangle {
        id: windowBackground
        color: Style.backgroundColor
        radius: Style.trayWindowRadius
        border.color: Style.ncTextColor
        anchors.fill: parent
    }

    ColumnLayout {
        id: contentLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Style.standardSpacing
        anchors.rightMargin: Style.standardSpacing
        spacing: Style.standardSpacing
        NCBusyIndicator {
            id: busyIndicator
            Layout.topMargin: Style.standardSpacing
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.iconWidth
            Layout.preferredHeight: root.iconWidth
            imageSourceSizeHeight: root.iconWidth
            imageSourceSizeWidth: root.iconWidth
            padding: 0
            color: Style.ncTextColor
            running: true
        }
        Label {
            id: labelFileName
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            text: root.fileName
            elide: Text.ElideRight
            font.bold: true
            font.pixelSize: root.fontPixelSize
            color: Style.ncTextColor
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            id: labelMessage
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: Style.standardSpacing
            text: qsTr("Opening for local editing")
            elide: Text.ElideRight
            font.pixelSize: root.fontPixelSize
            color: Style.ncTextColor
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
