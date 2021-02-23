defmodule StringStreamTest do
  use ExUnit.Case
  doctest StringStream

  test "StringStream by_line" do
    assert StringStream.by_line([]) |> Enum.to_list() == []
    assert StringStream.by_line(["a"]) |> Enum.to_list() == ["a"]
    assert StringStream.by_line(["ab"]) |> Enum.to_list() == ["ab"]
    assert StringStream.by_line(["ab", ""]) |> Enum.to_list() == ["ab"]
    assert StringStream.by_line(["ab", "cd"]) |> Enum.to_list() == ["abcd"]
    assert StringStream.by_line(["ab\n"]) |> Enum.to_list() == ["ab"]
    assert StringStream.by_line(["ab\ncd"]) |> Enum.to_list() == ["ab", "cd"]
    assert StringStream.by_line(["ab\ncd\n"]) |> Enum.to_list() == ["ab", "cd"]
    assert StringStream.by_line(["ab\ncd\nef"]) |> Enum.to_list() == ["ab", "cd", "ef"]

    assert StringStream.by_line(["ab\n", "cd\n"]) |> Enum.to_list() == ["ab", "cd"]
    assert StringStream.by_line(["ab\n", "cd"]) |> Enum.to_list() == ["ab", "cd"]
    assert StringStream.by_line(["ab", "\ncd"]) |> Enum.to_list() == ["ab", "cd"]
    assert StringStream.by_line(["ab", "\ncd\n"]) |> Enum.to_list() == ["ab", "cd"]

    assert StringStream.by_line(["ab\n", "cd", "ef\ngh", "\nij"]) |> Enum.to_list() == [
             "ab",
             "cdef",
             "gh",
             "ij"
           ]
  end

  #  test "split1" do
  #   {mu, _} = :timer.tc(&run_test1/1, [1000000])
  #   IO.puts("split1: #{mu / 1000} ms")
  # end

  # test "split2" do
  #   {mu, _} = :timer.tc(&run_test2/1, [1000000])
  #   IO.puts("split2: #{mu / 1000} ms")
  # end

  # def run_test1(0) do

  # end

  # def run_test1(counter) do
  #    false =  StringStream.a("abc\n")
  #    true =  StringStream.a("abc")
  #   run_test1(counter - 1)
  # end

  # def run_test2(0) do

  # end

  # def run_test2(counter) do
  #   false =  StringStream.b("\nabc")
  #   true =  StringStream.b("abc")
  #   run_test2(counter - 1)
  # end
end
