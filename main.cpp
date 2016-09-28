#include <QDebug>
#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
#ifdef Q_OS_ANDROID
    engine.load(QUrl(QStringLiteral("qrc:/mainandroid.qml")));
#else
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#endif

    return app.exec();
}

