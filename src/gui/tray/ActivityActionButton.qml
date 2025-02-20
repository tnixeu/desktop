import QtQuick 2.15
import QtQuick.Controls 2.3
import Style 1.0
import com.nextcloud.desktopclient 1.0

AbstractButton {
    id: root

    property string toolTipText: ""

    property bool primaryButton: false

    property string imageSource: ""
    property string imageSourceHover: ""

    property color adjustedHeaderColor: Style.adjustedCurrentUserHeaderColor
    property color textColor: primaryButton ? adjustedHeaderColor : Style.ncTextColor
    property color textColorHovered: primaryButton ? Style.currentUserHeaderTextColor : Style.ncTextColor

    property string verb: ""
    property bool isTalkReplyButton: false


    background: NCButtonBackground {
        color: Style.currentUserHeaderColor
        hovered: root.hovered
        visible: root.primaryButton
    }

    contentItem: Loader {
        id: contentItemLoader
        active: true
        sourceComponent: root.primaryButton ? primaryButtonContent : textButtonContent
    }

    ToolTip {
        id: customTextButtonTooltip
        text: root.toolTipText
        delay: Qt.styleHints.mousePressAndHoldInterval
        visible: root.toolTipText !== "" && root.hovered
        contentItem: Label {
            text: customTextButtonTooltip.text
            color: Style.ncTextColor
        }
        background: Rectangle {
            border.color: Style.menuBorder
            color: Style.backgroundColor
        }
    }

    Component {
        id: textButtonContent
        TextButtonContents {
            anchors.fill: parent
            hovered: root.hovered
            text: root.text
            textColor: root.textColor
            textColorHovered: root.textColorHovered

            bold: root.primaryButton
        }
    }

    Component {
        id: primaryButtonContent
        NCButtonContents {
            anchors.fill: parent
            hovered: root.hovered
            imageSourceHover: root.imageSourceHover
            imageSource: root.imageSource
            text: root.text
            textColor: root.textColor
            textColorHovered: root.textColorHovered
            bold: root.primaryButton
        }
    }
}
