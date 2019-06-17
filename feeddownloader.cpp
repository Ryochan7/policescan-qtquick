#include "feeddownloader.h"

FeedDownloader::FeedDownloader(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
}

void FeedDownloader::startScanFeed(int feedId)
{
    QNetworkRequest request(QUrl(QString("http://m.broadcastify.com/?feedId=%1").arg(feedId)));
    QNetworkReply *reply = manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &FeedDownloader::processFeedReply);
}

void FeedDownloader::processFeedReply()
{
    QNetworkReply *reply = (QNetworkReply*)QObject::sender();
    if (reply->error() == QNetworkReply::NoError)
    {
        QString url = parseFeedUrl(QString(reply->readAll()));
        if (!url.isEmpty())
        {
            emit feedReady(url);
        }
        else
        {
            emit parseFail("Feed not found");
        }
    }
    else
    {
        emit error("Network failure");
    }

    reply->deleteLater();
}

QString FeedDownloader::parseFeedUrl(QString text)
{
    QRegExp rx("<audio .* src=\"([0-9A-Za-z.:?/=]+)\" type=\"audio/mp3\"");
    QString temp;
    int ind = rx.indexIn(text);
    if (ind >= 0)
    {
        temp = rx.cap(1);
    }

    return temp;
}
