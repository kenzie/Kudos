# Kudos!

Use Twitter's Streaming API to catch all 'congrats' messages for authorized Twitter users. Send notification of any matches with a link to the original tweet.

Start the server and daemon with:
  foreman start

Run the tests with:
  foreman run bundle exec ruby test/...

## Sinatra

A simple Sinatra app has been setup to handle Twitter oAuth to start tracking users and capturing their email addresses for notification.

## User Stream

We're currently limited to Twitter's User Stream, so we'll only be tracking one user at a time as a proof of concept.

## Filter

The stream will be put through the Filter class to find matching kudo replies.

## Trace

Matches are traced to their originating tweet with the Trace class.

## Notification

Origins will be notified on as an email to the signed up user.

## Reference Docs

+ [User Stream Docs](https://dev.twitter.com/docs/streaming-apis/streams/user)
+ [TweetStream Gem](https://github.com/intridea/tweetstream)
+ [Twitter Gem](https://github.com/sferik/twitter)