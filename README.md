# Object State Tracker

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

```sh
% ./bin/setup
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
