# LoggerStatsd

[![Build Status](https://travis-ci.org/steffenix/logger_statsd.svg?branch=master)](https://travis-ci.org/steffenix/logger_statsd)
[![Hex.pm](https://img.shields.io/hexpm/v/logger_statsd.svg?style=flat-square)](https://hex.pm/packages/logger_statsd)

LoggerJsonFileBackend is elixir `logger` backend that count the errors/warns... and send it to statsd

## Installation

[Available in Hex](https://hex.pm/packages/logger_statsd), the package can be installed
by adding `logger_statsd` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:logger_statsd, "~> 0.1.4"}]
end
```

## Configuration

You need a valid [statsd](https://github.com/CargoSense/ex_statsd) configuration

```
config :logger,
  backends: [{LoggerStatsdLogger, :statsd_logger}]

config :logger, :statsd_logger,
  level: :info
```
