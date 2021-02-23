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

  defp tag([]) do
    []
  end

  defp tag([e]) do
    [e]
  end

  defp tag([e| tail]) do
    ["\n" <> e  | tag(tail)]
  end


  # def a(str) do
  #   case String.split(str, "\n", parts: 2) do
  #     [_] -> true
  #     [_, _] -> false
  #   end
  # end

  # def b(str) do
  #   case str do
  #     "\n" <> _ -> false
  #     _ -> true
  #   end

  # end

  defp chunk_fun(e, acc) do
    case e do
      "\n" <> rest -> {:cont, acc <> rest, ""}
      rest -> {:cont, acc <> rest}
    end
  end

  defp after_fun("") do
    {:cont, ""}
  end

  defp after_fun(acc) do
    {:cont, acc, ""}
  end
end
