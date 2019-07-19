#include <QUrlQuery>

#include "feeddownloader.h"

FeedDownloader::FeedDownloader(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
}

void FeedDownloader::startScanFeed(int feedId)
{
    QNetworkRequest request(QUrl(QString("https://www.broadcastify.com/listen/webpl.php?feedId=%1").arg(feedId)));
    QUrl params;
    QUrlQuery query;
    query.addQueryItem("t", "14");
    params.setQuery(query);
    QByteArray tempBa;
    tempBa.append("t=14");
    //tempBa = params.toEncoded(QUrl::RemoveFragment);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
        "application/x-www-form-urlencoded");
    request.setRawHeader("webAuth", "74f440ad812f0cc2192ab782e27608cc");
    QNetworkReply *reply = manager->post(request, tempBa);
    //QNetworkReply *reply = manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &FeedDownloader::processFeedReply);
}

void FeedDownloader::processFeedReply()
{
    QNetworkReply *reply = static_cast<QNetworkReply*>(QObject::sender());
    if (reply->error() == QNetworkReply::NoError)
    {
        QString pageText = QString(reply->readAll());
        //qDebug() << pageText;
        QString url = parseFeedUrl(pageText);
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
