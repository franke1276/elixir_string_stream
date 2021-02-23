# StringStream

Reframes a stream of strings that every item is a line
## Examples
```elixir
  iex> StringStream.by_line(["ab", "cd", "ef\ngh"]) |> Enum.to_list()
  ["abcdef", "gh"]
```
