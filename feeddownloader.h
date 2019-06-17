#ifndef FEEDDOWNLOADER_H
#define FEEDDOWNLOADER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class FeedDownloader : public QObject
{
    Q_OBJECT
public:
    explicit FeedDownloader(QObject *parent = nullptr);
    Q_INVOKABLE void startScanFeed(int feedId);

protected:
    void processFeedReply();
    QString parseFeedUrl(QString text);

    QNetworkAccessManager *manager;

signals:
    void feedReady(QString url);
    void error(QString error);
    void parseFail(QString msg);

public slots:
};

#endif // FEEDDOWNLOADER_H
