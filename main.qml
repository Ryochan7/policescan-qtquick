import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

import "stations.js" as RadioDatabase


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Police Scanner Test")

    property string currentPlayStatus: "";

    Component.onCompleted: {
        countriesListModel.clear();
        statesModel.clear();
        countiesModel.clear();
        scannerStationModel.clear();

        var temp = RadioDatabase.getCountries();
        for (var i = 0, len = temp.length; i < len; i++)
        {
            var country = temp[i];
            countriesListModel.append({"text": country});
            var regions = RadioDatabase.getRegionsForCountry(country);

            for (var j = 0, regionlen = regions.length; j < regionlen; j++)
            {
                var region = regions[j];
                statesModel.append({"text": region});
                var counties = RadioDatabase.getCountiesForRegion(country, region);

                for (var k = 0, countieslen = counties.length; k < countieslen; k++)
                {
                    var county = counties[k];
                    countiesModel.append({"text": county})
                    var stations = RadioDatabase.getStationsForCounty(country, region, county);

                    for (var station in stations)
                    {
                        var tempobject = {
                            "text" : station,
                            "url" : stations[station],
                        }

                        scannerStationModel.append(tempobject);
                    }
                }
            }
        }
    }

    MediaPlayer {
        id: mediaPlayer
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            /*MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            */

            MenuItem {
                text: qsTr("Exit")
                onTriggered: {
                    Qt.quit();
                }
            }
        }
    }

    ColumnLayout {
        id: controlLayout

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        //anchors.bottom: parent.bottom
        //anchors.bottomMargin: 10

        spacing: 6

        ComboBox {
            id: countriesComboBox

            Layout.fillWidth: true

            model: ListModel {
                id: countriesListModel
            }

            onActivated: {
                statesModel.clear();

                var regions = RadioDatabase.getRegionsForCountry(country);
                for (var i = 0, regionlen = regions.length; i < regionlen; i++)
                {
                    var region = regions[i];
                    statesModel.append({"text": region});
                }
            }
        }

        ComboBox {
            id: statesComboBox

            Layout.fillWidth: true

            /*model: ListModel {
                ListElement {
                    text: "Lime Time"
                }
            }
            */
            model: ListModel {
                id: statesModel
            }

            onActivated: {
                countiesModel.clear();

                var country = countriesListModel.get(countriesComboBox.currentIndex).text;
                var region = statesModel.get(index).text;
                var counties = RadioDatabase.getCountiesForRegion(country, region);

                for (var i = 0, countieslen = counties.length; i < countieslen; i++)
                {
                    var county = counties[i];
                    countiesModel.append({"text": county});
                }
            }
        }

        ComboBox {
            id: countiesComboBox

            Layout.fillWidth: true

            model: ListModel {
                id: countiesModel
            }

            onActivated: {
                scannerStationModel.clear();

                var country = countriesListModel.get(countriesComboBox.currentIndex).text;
                var region = statesModel.get(statesComboBox.currentIndex).text;
                var county = countiesModel.get(index).text;
                var stations = RadioDatabase.getStationsForCounty(country, region, county);

                for (var station in stations)
                {
                    var tempobject = {
                        "text" : station,
                        "url" : stations[station],
                    }

                    scannerStationModel.append(tempobject);
                }
            }
        }

        ComboBox {
            id: scannerStationComboBox

            Layout.fillWidth: true

            model: ListModel {
                id: scannerStationModel
            }

            textRole: "text"
        }

        Item {
            height: 10
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "Play"
                Layout.fillWidth: true

                onClicked: {
                    mediaPlayer.stop();
                    var curstation = scannerStationModel.get(scannerStationComboBox.currentIndex);

                    if (curstation !== undefined)
                    {
                        mediaPlayer.source = curstation.url;
                        mediaPlayer.play();
                        currentPlayStatus = curstation.text;
                    }
                    else
                    {
                        currentPlayStatus = "";
                    }
                }
            }

            Button {
                text: "Stop"
                Layout.fillWidth: true

                onClicked: {
                    mediaPlayer.stop();
                    currentPlayStatus = "";
                }
            }

            Button {
                text: "TEST [Chicago Police]"
                Layout.fillWidth: true

                onClicked: {
                    if (mediaPlayer.status === MediaPlayer.PlayingState)
                    {
                        mediaPlayer.stop();
                    }

                    mediaPlayer.source = "http://www.broadcastify.com/scripts/playlists/1/763/-5891106616.m3u";
                    mediaPlayer.play();
                    currentPlayStatus = "Chicago Police"
                }
            }

            Button {
                text: "Exit"
                Layout.fillWidth: true

                onClicked: {
                    console.log("EXIT PROGRAM");
                    Qt.quit();
                }
            }
        }

        Rectangle {
            height: 20
        }

        Text {
            id: statusText
            text: "Playing: " + currentPlayStatus
            visible: currentPlayStatus !== "";
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
    }

    Item {
        id: item1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: controlLayout.bottom
        anchors.bottom: parent.bottom
        anchors.margins: { leftMargin: 10; rightMargin: 10; topMargin: 20; bottomMargin: 20; }
        //Layout.fillWidth: true
        //Layout.fillHeight: true
        //height: 200

        Image {
            id: bicusDickus
            width: parent.width
            height: parent.height
            source: "qrc:/DICIS.jpg"
            fillMode: Image.PreserveAspectCrop
        }
    }
}

