#include <QDebug>
//#include <QApplication>
#ifdef QT_WIDGETS_LIB
  #include <QApplication>
#else
  #include <QGuiApplication>
#endif
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "feeddownloader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication app(argc, argv);
#endif

    QQmlApplicationEngine engine;
    FeedDownloader feeddownobj;
    engine.rootContext()->setContextProperty("feeddown", &feeddownobj);

#ifdef Q_OS_ANDROID
    engine.load(QUrl(QStringLiteral("qrc:/mainandroid.qml")));
#else
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#endif




    return app.exec();
}

