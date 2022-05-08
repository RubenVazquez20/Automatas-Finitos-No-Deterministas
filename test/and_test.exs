defmodule AndTest do
  use ExUnit.Case
  doctest And

  test "greets the world" do
    assert And.hello() == :world
  end
end
