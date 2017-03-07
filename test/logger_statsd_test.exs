defmodule LoggerStatsdTest do
  use ExUnit.Case, async: false
  alias LoggerStatsd.Buffer
  require Logger

  @backend {LoggerStatsdLogger, :test}

  Logger.add_backend @backend

  setup_all do
    Buffer.set_opt(:interval, nil)
  end

  setup do
    Buffer.reset
    Logger.configure_backend(@backend, [level: :error])
    :ok
  end

  test "error is buffered" do
    Logger.error("It works")
    Process.sleep(100)
    assert Buffer.dump_table() == [error: 1]
  end

  test "works with different levels" do
    Logger.configure_backend(@backend, [level: :info])
    Logger.error("It's an error")
    Logger.warn("It's an warn")
    Logger.info("It's an info")
    Process.sleep(100)
    assert Buffer.dump_table() == [error: 1, info: 1, warn: 1]
  end

  test "buffer" do
    Logger.error("It's an error")
    Logger.error("It's an error")
    Logger.error("It's an error")
    Process.sleep(100)
    assert Buffer.dump_table() == [error: 3]
  end
end
