#!/bin/sh

FEEDID=${1:-""}
if [ -z "$FEEDID" ]; then
  echo "Must specify a Broadcastify feed id."
  exit 1
fi

#curl "http://www.broadcastify.com/listen/feed/$FEEDID/web" | grep "audio" | grep "src="
curl "http://m.broadcastify.com/?feedId=$FEEDID" | grep "audio" | grep "src="

