# Kudos!

Use Twitter's Streaming API to catch all 'congrats' messages for authorized Twitter users. Send notification of any matches with a link to the original tweet.

## Sinatra

A simple Sinatra app has been setup to handle Twitter oAuth to start tracking users.

## User Stream

We're currently limited to Twitter's User Stream, so we'll only be tracking one user at a time as a proof of concept.

## Matches

New matches will be picked from the stream.

## Notification

Any match will be notified on as an email or direct message to the watching user.

## Reference Docs

+ [Public Stream Docs](https://dev.twitter.com/docs/streaming-apis/streams/public)
+ [TweetStream Gem](https://github.com/intridea/tweetstream)
+ [Twitter Gem](https://github.com/sferik/twitter)