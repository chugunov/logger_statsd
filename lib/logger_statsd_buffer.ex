defmodule LoggerStatsd.Buffer do
  @moduledoc """
  We use a buffer to send the number of error every seconds
  """
  use Buffer.Write.Count, interval: 1000

  @spec write(list(term)) :: :ok
  def write(counter_list) do
    hostname = get_hostname()
    if length(counter_list) != 0 do
      Enum.each(counter_list, fn({counter, val}) ->
        key = get_key(val, hostname)
        ExStatsD.counter(key, counter)
      end)
    end
    :ok
  end

  @spec get_key(String.t, String.t) :: String.t
  defp get_key(val, hostname) do
    "loggerstatsd.#{hostname}.#{val}"
  end

  @spec get_hostname :: String.t
  defp get_hostname do
    case :inet.gethostname do
    {:ok, hostname} -> hostname
    _ -> ""
    end
  end
end
