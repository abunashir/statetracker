# Object State Tracker

[![CircleCI](https://circleci.com/gh/abunashir/statetracker.svg?style=svg&circle-token=9ac0c3c1710d7572afe6d6c21d2b896b21feab90)](https://circleci.com/gh/abunashir/statetracker)

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

```sh
% ./bin/setup
```

And once that's done then copy the `.env` sample and update it with your
actual configuration.

```sh
cp .sample.env .env

# Edit configuration
vim .env
```

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [Heroku Local]:

```sh
% heroku local
```

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Deploying

If you have previously run the `./bin/setup` script, you can deploy to staging
and production with:

```sh
$ ./bin/deploy heroku-remote
```
