# StringStream

Regroup a stream of strings that it generates a chunk for each line
## Examples
```elixir
  iex> StringStream.by_line(["ab", "cd", "ef\ngh"]) |> Enum.to_list()
  ["abcdef", "gh"]
```
