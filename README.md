# Kudos!

Use Twitter's Streaming API to catch all 'congrats' messages (initial test with the Public Stream). Send notification of any matches with a link to the original tweet.

## Reference Docs

[Public Stream Docs](https://dev.twitter.com/docs/streaming-apis/streams/public)
[TweetStream Gem](https://github.com/intridea/tweetstream)
[Twitter Gem](https://github.com/sferik/twitter)

## StreamMonitor

Just a wrapper around the TweetStream gem to track the public stream for kudos keywords and handle any matches.

## Match

Trace a tweet to it's origin.

## Notify

Send a message with a link to the tweet.