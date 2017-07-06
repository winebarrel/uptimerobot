# UptimeRobot

[Uptime Robot](https://uptimerobot.com/) APIv2 client for Ruby.

[![Gem Version](https://badge.fury.io/rb/uptimerobot.svg)](http://badge.fury.io/rb/uptimerobot)
[![Build Status](https://travis-ci.org/winebarrel/uptimerobot.svg?branch=master)](https://travis-ci.org/winebarrel/uptimerobot)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uptimerobot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uptimerobot

## Usage

```ruby
require 'uptimerobot'

client = UptimeRobot::Client.new(api_key: 'u956-afus321g565fghr519')

client.getMonitors
# {
#   "stat": "ok",
#   "pagination": {
#     "offset": 0,
#     "limit": 50,
#     "total": 2
#   },
#   "monitors": [
#     {
#       "id": 777749809,
#       "friendly_name": "Google",
#       "url": "http://www.google.com",
#       "type": 1,
#       ...
#     },
#     {
#       "id": 777712827,
#       "friendly_name": "My Web Page",
#       "url": "http://mywebpage.com/",
#       "type": 1,
#       ...
#     },
#     ...

client.newMonitor(
  friendly_name: 'Google',
  url: 'http://www.google.com',
  type: UptimeRobot::Monitor::Type::HTTP,
  alert_contacts: '448,716'
)
```

## Test

    $ bundle exec rake

## Uptime Robot API reference

* https://uptimerobot.com/api
