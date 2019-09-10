import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtMultimedia 5.0

import "stations.js" as RadioDatabase


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Police Scanner Test")
    property var curstation;
    property var teststation: false;
    property var stationQueued: curstation !== null || teststation == true;

    property string currentPlayStatus: "";
    property real fontSizeMulti: {
        var temp = Screen.devicePixelRatio;
        if (Screen.devicePixelRatio > 1.0)
        {
            temp = temp * 0.75;
        }

        return temp;
    }

    Component.onCompleted: {
        countriesComboBox.model = null;
        statesComboBox.model = null;
        countiesComboBox.model = null;
        scannerStationComboBox.model = null;

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
                    if (k == 0)
                    {
                        var stations = RadioDatabase.getStationsForCounty(country, region, county);

                        for (var station in stations)
                        {
                            scannerStationModel.append(stations[station]);
                        }
                    }
                }
            }
        }

        countriesComboBox.model = countriesListModel;
        statesComboBox.model = statesModel;
        countiesComboBox.model = countiesModel;
        scannerStationComboBox.model = scannerStationModel;
    }

    property QtObject mediaPlayer: MediaPlayer {

    }

    header: ToolBar {
        ToolButton {
            text: "..."
            font.pointSize: 14 * fontSizeMulti
            font.bold: true
            anchors.right: parent.right
            rotation: 90.0;

            onClicked: {
                optionsMenu.open();
            }
        }

        Menu {
            id: optionsMenu
            transformOrigin: Menu.TopRight
            x: parent.width - width

            MenuItem {
                font.pointSize: 14 * fontSizeMulti
                text: "Exit"
                onTriggered: Qt.quit();
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

        spacing: 8

        ComboBox {
            id: countriesComboBox

            Layout.fillWidth: true
            font.pointSize: 14 * fontSizeMulti
            //Layout.preferredHeight: 80

            model: ListModel {
                id: countriesListModel
            }

            onActivated: {
                statesComboBox.model = null;
                statesModel.clear();

                var regions = RadioDatabase.getRegionsForCountry(currentText);
                for (var i = 0, regionlen = regions.length; i < regionlen; i++)
                {
                    var region = regions[i];
                    statesModel.append({"text": region});
                }

                statesComboBox.model = statesModel;
            }
        }

        ComboBox {
            id: statesComboBox

            Layout.fillWidth: true
            font.pointSize: 14 * fontSizeMulti
            //Layout.preferredHeight: 80

            model: ListModel {
                id: statesModel
            }

            onActivated: {
                countiesComboBox.model = null;
                countiesModel.clear();

                var country = countriesListModel.get(countriesComboBox.currentIndex).text;
                var region = statesModel.get(index).text;
                var counties = RadioDatabase.getCountiesForRegion(country, region);

                for (var i = 0, countieslen = counties.length; i < countieslen; i++)
                {
                    var county = counties[i];
                    countiesModel.append({"text": county});
                }

                countiesComboBox.model = countiesModel;
            }
        }

        ComboBox {
            id: countiesComboBox

            Layout.fillWidth: true
            font.pointSize: 14 * fontSizeMulti
            //Layout.preferredHeight: 80

            model: ListModel {
                id: countiesModel
            }

            onActivated: {
                scannerStationComboBox.model = null;
                scannerStationModel.clear();

                var country = countriesListModel.get(countriesComboBox.currentIndex).text;
                var region = statesModel.get(statesComboBox.currentIndex).text;
                var county = countiesModel.get(index).text;
                var stations = RadioDatabase.getStationsForCounty(country, region, county);

                for (var station in stations)
                {
                    scannerStationModel.append(stations[station]);
                }

                scannerStationComboBox.model = scannerStationModel;
            }
        }

        ComboBox {
            id: scannerStationComboBox

            Layout.fillWidth: true
            font.pointSize: 14 * fontSizeMulti
            //Layout.preferredHeight: 80

            model: ListModel {
                id: scannerStationModel
            }

            textRole: "name"
        }

        Item {
            Layout.preferredHeight: 10
        }

        RowLayout {
            id: buttonRow
            Layout.fillWidth: true

            Button {
                text: "Play"
                Layout.fillWidth: true
                //Layout.preferredHeight: 80
                font.pointSize: 14 * fontSizeMulti

                onClicked: {
                    if (mediaPlayer.playbackState === MediaPlayer.PlayingState)
                    {
                        mediaPlayer.stop();
                    }

                    curstation = scannerStationModel.get(scannerStationComboBox.currentIndex);
                    teststation = false;
                    buttonRow.enabled = false;
                    feeddown.startScanFeed(curstation.feedId);
                }
            }

            Button {
                text: "Stop"
                Layout.fillWidth: true
                //Layout.preferredHeight: 80
                font.pointSize: 14 * fontSizeMulti

                onClicked: {
                    if (mediaPlayer.playbackState === MediaPlayer.PlayingState)
                    {
                        mediaPlayer.stop();
                    }

                    curstation = null;
                    teststation = false;
                    currentPlayStatus = "";
                }
            }

            Button {
                text: "TEST [Chicago Police]"
                Layout.fillWidth: true
                //Layout.preferredHeight: 80
                font.pointSize: 14 * fontSizeMulti

                onClicked: {
                    if (mediaPlayer.playbackState === MediaPlayer.PlayingState)
                    {
                        mediaPlayer.stop();
                    }

                    curstation = null;
                    teststation = true;
                    buttonRow.enabled = false;
                    feeddown.startScanFeed(17693);

                }
            }

            Button {
                text: "Exit"
                Layout.fillWidth: true
                //Layout.preferredHeight: 80
                font.pointSize: 14 * fontSizeMulti

                onClicked: {
                    console.log("EXIT PROGRAM");
                    Qt.quit();
                }
            }
        }

        Rectangle {
            Layout.preferredHeight: 20
        }

        Text {
            id: statusText
            text: stationQueued ? "Playing: " + currentPlayStatus : currentPlayStatus;
            visible: currentPlayStatus !== "";
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            font.pointSize: 12 * fontSizeMulti
        }
    }

    Item {
        id: item1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: controlLayout.bottom
        anchors.bottom: parent.bottom
        anchors.margins: { leftMargin: 10; rightMargin: 10; topMargin: 20; bottomMargin: 20; }
        visible: height >= 100 ? true : false

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

    Connections
    {
        target: feeddown
        onFeedReady: function (url)
        {
            if (curstation !== null)
            {
                mediaPlayer.source = url;
                mediaPlayer.play();
                currentPlayStatus = curstation.name;
            }
            else if (teststation)
            {
                mediaPlayer.source = url;
                mediaPlayer.play();
                currentPlayStatus = "Chicago Police"
            }
            else
            {
                currentPlayStatus = "Invalid selection";
            }

            buttonRow.enabled = true;
        }

        onError: function (errormsg)
        {
            currentPlayStatus = errormsg;
            buttonRow.enabled = true;
        }

        onParseFail: function (msg)
        {
            currentPlayStatus = msg;
            buttonRow.enabled = true;
        }
    }
}

