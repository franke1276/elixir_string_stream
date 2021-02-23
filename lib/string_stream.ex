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
    |> Stream.flat_map(&split_string/1)
    |> Stream.chunk_while("", &chunk_fun/2, &after_fun/1)
    |> Enum.to_list()
  end

  def split_string(string) do
    case String.split(string, "\n") do
        [head] -> [head]
        list -> tag(list)
      end
  end

  def tag([]) do
    []
  end
  def tag([e]) do
    [e]
  end

  def tag([e| tail]) do
    [e <> "\n" | tag(tail)]
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
