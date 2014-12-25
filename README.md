# UptimeRobot

[Uptime Robot](https://uptimerobot.com/) API client for Ruby.

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
# => {"stat"=>"ok",
#     "offset"=>"0",
#     "limit"=>"50",
#     "total"=>"2",
#     "monitors"=>
#      {"monitor"=>
#        [{"id"=>"128795",
#          "friendlyname"=>"Yahoo",
#          "url"=>"http://www.yahoo.com/",
#          "type"=>"1",
#          "subtype"=>"",
#          ...

client.newMonitor(
  :monitorFriendlyName => 'Google',
  :monitorURL => 'http://www.google.com',
  :monitorType => UptimeRobot::Monitor::Type::HTTP,
  :monitorAlertContacts => '448-716'
)
```

## Test

    $ bundle exec rake

## Uptime Robot API reference

* https://uptimerobot.com/api
