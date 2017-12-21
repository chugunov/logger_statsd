defmodule LoggerStatsd.Buffer do
  @moduledoc """
  We use a buffer to send the number of error every seconds
  """
  use Buffer.Write.Count, interval: 1000

  @spec write(list(term)) :: :ok
  def write(counter_list) do
    if length(counter_list) != 0 do
      Enum.each(counter_list, fn({counter, val}) ->
        counter_name = get_key(counter)
        ExStatsD.counter(val, counter_name)
      end)
    end
    :ok
  end

  @spec get_key(String.t) :: String.t
  defp get_key(val) do
    "loggerstatsd.#{val}"
  end
end
