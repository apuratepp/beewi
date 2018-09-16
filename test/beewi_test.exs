defmodule BeewiTest do
  use ExUnit.Case
  doctest Beewi

  test "greets the world" do
    assert Beewi.hello() == :world
  end
end
