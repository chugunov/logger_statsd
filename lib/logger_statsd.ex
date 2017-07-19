defmodule LoggerStatsd do
  @moduledoc """
  Documentation for LoggerStatsdLogger.
  LoggerStatsd get errors from logger and sends it to statsd
  to be used to display in grafana
  """
  use Application
  require Logger
  alias LoggerStatsd.Buffer
  @spec start(Application.start_type, start_args :: term) :: Supervisor.on_start
  def start(_type, _args) do
    children = [
      Buffer.worker
    ]
    opts = [
      strategy: :one_for_one,
      max_restarts: 1_000_000,
      max_seconds: 1,
      name: LoggerStatsd
    ]
    Supervisor.start_link(children, opts)
  end
end
