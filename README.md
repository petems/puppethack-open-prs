# puppet-hack-open-prs

A simple Sinatra APP to check open Pull Requests on PuppetLabs namespace.

It's heavily based on the [junkie](https://github.com/leomilrib/junkie) app. It's awesome, go check it out!

## Using it
You can use it by [accessing the herokuapp](http://puppet-community-open-prs.herokuapp.com/).

## Getting your own
You can run it on your machine or sever by follwing this steps:

### Running locally
 - `git clone <this repo>`
 - `bundle install`
 - config your `~/.netrc` file to include your GitHub authentication token:
 ```
 machine api.github.com
  login janedoe
  password hunter2
 ```
 -  `bundle exec ruby app.rb`

### Running on a Heroku app
 - `git clone <this repo>`
 - `bundle install`
 - `git remote add heroku <<Your Heroku app URL>>`
 - `heroku config:set GITHUB_APP_ID=<<Add your GITHUB_APP_ID to Heroku app>>`
 - `heroku config:set GITHUB_APP_SECRET=<<Add your GITHUB_APP_SECRET to Heroku app>>`
 - `heroku config:set SESSION_SECRET=<<Add your SESSION_SECRET to Heroku app>>`
 - `git push heroku master`
 - `heroku open`

## Contributing
See the [contributing guide](CONTRIBUTING.md).
