# Guild API

#### Dependencies
 - Ruby 2.6.5
 - Postgres

I use `rvm` to manage ruby versions locally.  To install and use this version:

```sh
$ rvm install 2.6.5
$ rvm use 2.6.5
```

I am running postgres locally, you can install it with `brew` or the native postgres app for Mac OS.

#### Installation

This is a typical Rails app, so installation is straightfoward:
```sh
$ cd guild-api
$ bundle install
$ bundle exec rails db:setup
```

#### Running the test suite

All the code is fully tested using RSpec.  There are basic unit tests for the models, mainly testing the associations work correctly.  Along with the unit tests, there are request specs that test the API through a complete request, including making assertions against the returned payload and response status.

In order to invoke the tests, simply run:
```sh
$ bundle exec rake spec
```

#### Running the server
```sh
$ bundle exec rails s
```

Once the server is running, and the database is seeded, you can hit the API with a simple curl command.  Given the seeds have been run, you should have 2 users with id values of `1` and `2`, and some messages between them.  So a command like:
```sh
$ curl localhost:3000/messages/1/recent
```
Will return a list of recent messages for the user with id=1.

There are also test cases that exercise this exact request, and others, and the various edge cases associated with each endpoint.

#### Basic Architecture
For the requirements of this chat app, the DB tables are as kept as simple as possible.  There is a `users` table and a `messages` table.  Each message has a `recipient` and a `sender`, both of which reference foreign keys on the `users` table.

#### Feature Requirements
This section lists the feature set for the API and which endpoints correspond to each respective feature.

1. A short text message can be sent from one user (the sender) to another (the recipient).
    - `POST - "/messages"`
    - `Params - :sender_id, :recipient_id, :body`
    - This will return a JSON representation of the message

2. Recent messages can be requested for a recipient from a specific sender - with a limit of 100 messages or all messages in last 30 days.
    - `GET - "/messages/:recipient_id/recent/:sender_id`
    - `Params - :recipient_id, :sender_id`
    - Messages will be ordered in descending order with the newest messages appearing first, with a limit of 100

3. Recent messages can be requested from all senders - with a limit of 100 messages or all messages in last 30 days.
    - `GET - "/messages/:recipient_id/recent"`
    - `Params - :recipient_id`
    - Messages will be ordered in descending order with the newest messages appearing first, with a limit of 100

4. EXTRA - Display a list of all the users
    - `GET - /users`
    - I figured this would be useful so you can get the ids of some users in order to test message creation.

#### Future Considerations
- Authentication - currently there is none, but this would be necessary in reality.  For an API consumer, I would imagine that the sender of a message would be the current user who is logged into the app.

- Code organization - most of the logic happens in the controller, which is usually not the case, or shouldn't be, but since there is so little code, I didn't think it was worth it to break the code apart into various components that handle requests to different endpoints or handle various business logic.  For example, if/when message creation became a bit more complex, I might create an object solely responsible for that and factor out any/all of that logic from the controller.

- Handling what happens _after_ a message is created - Ideally, a user shouldn't have to poll the API for new messages.  Although not a required feature, I would probably want some type of hook to fire in order to alert the recipient that they have a new message.  Something like Pusher would work well.  So, granted that we had auth, and some type of front end, I can imagine a scenario where the user has a websocket open and once the message is created, we'd push the payload to the front end so that the new message would just appear in the chat.

- Obfuscating the User and Message ids - I wouldn't expose the integer ids of any databse records in the URL.  Instead, I might use something like hashids to hash the ids and obfuscate any info about the DB, like how many users we have and so fourth.

- Setting up factories for test - It would be nice to introduce some testing affordances, like factories for the models in order to easily create test and/or seed data.

