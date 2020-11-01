defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "convert banana" do
    assert Identicon.hash_input("banana") == %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]}
  end

  test "convert transistor" do
    assert Identicon.hash_input("transistor") == %Identicon.Image{hex: [170, 160, 215, 138, 244, 154, 47, 188, 47, 122, 216, 251, 177, 29, 225, 170]}
  end
end
