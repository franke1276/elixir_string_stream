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

   test "split3" do
    {mu, _} = :timer.tc(&run_test3/1, [1000000])
    IO.puts("split3: #{mu / 1000} ms")
  end



  def run_test3(0) do

  end

  def run_test3(counter) do
    ["abcdefg\n","hijkl\n","nop"] =  StringStream.split_string("abcdefg\nhijkl\nnop")
    run_test3(counter - 1)
  end
end
