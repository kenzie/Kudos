# Kudos!

Use Twitter's Streaming API to catch all 'congrats' messages sent in reply to one of your follower's tweets. Send email notification about that original tweet.

Edit sample.env and copy to .env, then start the service and daemon with:
    foreman start

Run the tests with:
    foreman run bundle exec ruby test/...

## Sinatra

A Sinatra web service handles Twitter oAuth to persist each signed up user's screen name, email, and oauth credentials.

## User Stream

We're currently limited to Twitter's User Stream, so we'll only be tracking one user at a time as a proof of concept.

## Response

Each response from the stream is processes by the Response class which filters, traces, and notifies as necessary.

## Filter

The stream will be put through the Filter class to find matching kudo replies.

## Trace

Matches are traced to their originating tweet with the Trace class.

## Notification

Notifications on originating Kudos tweets are sent by email to the signed up user.

## TODO

0. Resolve false positives when a follower sends congrats to someone else.
1. Build notification email delivery.
2. Try out daemon in production (Heroku worker)
3. Daemon, Service, and User can probably be pulled into the Kudos module.
4. Integration tests for the Sinatra service.
5. Match a Kudos tweet to the user that needs to be notified. We'll need to persist and maintain (REST API) a list of each signed up users' followers so we can do a simple lookup.
6. Get access to the Site Stream and build functionality for adding/removing users from that stream.

## Reference Docs

+ [User Stream Docs](https://dev.twitter.com/docs/streaming-apis/streams/user)
+ [EM-Twitter Gem](https://github.com/spagalloco/em-twitter)
+ [Twitter Gem](https://github.com/sferik/twitter)