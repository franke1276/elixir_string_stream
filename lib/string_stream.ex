defmodule StringStream do
  @moduledoc """
  Documentation for `StringStream`.
  """

  @doc """
  Regroup a stream of strings that it generates a chunk for each line

  ## Examples

    iex> StringStream.by_line(["ab", "cd", "ef\\ngh"]) |> Enum.to_list()
    ["abcdef", "gh"]

  """
  def by_line(stream) do
    stream
    |> split()
    |> Stream.chunk_while("", &chunk_fun/2, &after_fun/1)
    |> Enum.to_list()
  end

  defp split(stream) do
    stream
    |> Stream.flat_map(fn e ->
      case String.split(e, "\n")
           |> Enum.reverse() do
        [head] -> [head]
        [head | tail] -> [head | tail |> Enum.map(fn x -> x <> "\n" end)] |> Enum.reverse()
      end
    end)
  end

  defp chunk_fun(e, acc) do
    case String.split(e, "\n", parts: 2) do
      [head] -> {:cont, acc <> head}
      [head, tail] -> {:cont, acc <> head, tail}
    end
  end

  defp after_fun("") do
    {:cont, ""}
  end

  defp after_fun(acc) do
    {:cont, acc, ""}
  end
end
