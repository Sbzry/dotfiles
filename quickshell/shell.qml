import Quickshell
import QtQuick
//quickshell -p ~/.config/quickshell
//run that for launching quickshell
ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData

            screen: modelData
            height: 30
            color: "#1e1e2e"  // dark background

            anchors {
                bottom: true
                left: true
                right: true
            }
            //left row (planned for widgets/features)
            Row {
                anchors{
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 10
                }
                spacing: 20

                Text {
                    text: "Menu i guess"
                    color: "#cdd6f4"
                    font.pixelSize: 14
                }
            }
            // Center - App Launcher
            Row {
                anchors.centerIn: parent

                Text {
                    id: launcherButton
                    text: "Apps"
                    color: "#cdd6f4"
                    font.pixelSize: 14

                    MouseArea {
                        anchors.fill: parent
                        onClicked:{
                            //console.log("clicked, visible is: " + launcherPopup.visible)
                            launcherPopup.visible = !launcherPopup.visible
                            //console.log("clicked, visible is now: " + launcherPopup.visible)
                        }
                    }
                }
            }
            // Popup Menu
            PanelWindow {
                id: launcherPopup
                visible: false
                color: "#1e1e2e"
                width: 200
                height: 300

                exclusionMode: ExclusionMode.Ignore  // stops it from reserving space

                anchors.top: true
                margins.top: 30

                // center it horizontally
                margins.left: (screen.width / 2) - 100


                Column {
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 10
                    }
                    spacing: 5

                    // App entries
                    Repeater {
                        model: [
                            { name: "Firefox", cmd: "firefox" },
                            { name: "Terminal", cmd: "kitty" },
                            { name: "Files", cmd: "nautilus" },
                            { name: "VS Code", cmd: "code" },
                            { name: "Discord", cmd: "discord" }
                        ]

                        Rectangle {
                            width: parent.width
                            height: 40
                            color: hovered ? "#313244" : "transparent"
                            radius: 6

                            property bool hovered: false

                            Text {
                                anchors {
                                    left: parent.left
                                    verticalCenter: parent.verticalCenter
                                    leftMargin: 10
                                }
                                text: modelData.name
                                color: "#cdd6f4"
                                font.pixelSize: 14
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited: parent.hovered = false
                                onClicked: {
                                    Quickshell.exec(modelData.cmd)
                                    launcherPopup.visible = false
                                }
                            }
                        }
                    }
                }
            }
            // right row (date and time currently)
            Row {
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }
                spacing: 20

                Text {
                    id: clockText
                    color: "#cdd6f4"
                    font.pixelSize: 14
                    text: Qt.formatDateTime(new Date(), "ddd hh:mm MM/dd/yyyy")

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd hh:mm MM/dd/yyyy")
                    }
                }
            }
        }
    }
}