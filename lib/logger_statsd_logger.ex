defmodule LoggerStatsdLogger do
  @moduledoc """
  The genevent logger
  """
  use GenEvent

  @spec init(map) :: map
  def init({__MODULE__, name}) do
    {:ok, %{name: name, level: :error}}
  end

  @spec handle_call(any, map) :: map
  def handle_call({:configure, [level: level]}, state) do
    state = Map.put(state, :level, level)
    {:ok, :ok, state}
  end

  @spec handle_event(any, map) :: map
  def handle_event({level, _gl, {Logger, _, _, _}}, %{level: min_level} = state) do
    if (is_nil(min_level) or Logger.compare_levels(level, min_level) != :lt) do
      LoggerStatsd.Buffer.incr(level)
    end
    {:ok, state}
  end
end
