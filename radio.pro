TEMPLATE = app

CONFIG += c++11

QT += qml quick quickcontrols2

android {
  QT += av
}
else
{
  QT += multimedia
}

SOURCES += main.cpp \
    feeddownloader.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


# Default rules for deployment.
include(deployment.pri)

unix:!android: LIBS += -lssl -lcrypto
else: include($$(HOME)/Sources/android_openssl/openssl.pri)

unix:android: DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

unix:android: ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    feeddownloader.h


