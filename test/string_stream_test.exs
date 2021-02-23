defmodule StringStreamTest do
  use ExUnit.Case
  doctest StringStream

  test "StringStream by_line" do
    assert StringStream.by_line([]) == []
    assert StringStream.by_line(["a"]) == ["a"]
    assert StringStream.by_line(["ab"]) == ["ab"]
    assert StringStream.by_line(["ab", ""]) == ["ab"]
    assert StringStream.by_line(["ab", "cd"]) == ["abcd"]
    assert StringStream.by_line(["ab\n"]) == ["ab"]
    assert StringStream.by_line(["ab\ncd"]) == ["ab", "cd"]
    assert StringStream.by_line(["ab\ncd\n"]) == ["ab", "cd"]
    assert StringStream.by_line(["ab\ncd\nef"]) == ["ab", "cd", "ef"]

    assert StringStream.by_line(["ab\n", "cd\n"]) == ["ab", "cd"]
    assert StringStream.by_line(["ab\n", "cd"]) == ["ab", "cd"]
    assert StringStream.by_line(["ab", "\ncd"]) == ["ab", "cd"]
    assert StringStream.by_line(["ab", "\ncd\n"]) == ["ab", "cd"]
    assert StringStream.by_line(["ab\n", "cd", "ef\ngh", "\nij"]) == ["ab", "cdef", "gh", "ij"]
  end
end
