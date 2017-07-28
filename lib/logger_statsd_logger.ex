defmodule LoggerStatsdLogger do
  @moduledoc """
  The genevent logger
  """
  @behaviour :gen_event
  alias LoggerStatsd.Buffer

  @spec init(map) :: map
  def init({__MODULE__, name}) do
    {:ok, configure(name, [])}
  end

  @spec handle_call(any, map) :: map
  def handle_call({:configure, [level: level]}, state) do
    state = configure(state.name, [level: level])
    {:ok, :ok, state}
  end

  def handle_event({_level, gl, _event}, state) when node(gl) != node() do
    {:ok, state}
  end

  @spec handle_event(any, map) :: map
  def handle_event({level, _gl, {Logger, _, _, _}}, %{level: min_level} = state) do
    if (is_nil(min_level) or Logger.compare_levels(level, min_level) != :lt) do
      Buffer.incr(level)
    end
    {:ok, state}
  end

  defp configure(name, opts) do
    env = Application.get_env(:logger, name, [])
    opts = Keyword.merge(env, opts)
    level = Keyword.get(opts, :level, :error)
    %{name: name, level: level}
  end
end
