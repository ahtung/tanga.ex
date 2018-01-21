defmodule TangaTest do
  use ExUnit.Case
  doctest Tanga

  test "greets the world" do
    assert Tanga.hello() == :world
  end
end
