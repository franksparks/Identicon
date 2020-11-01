defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "convert banana" do
    assert Identicon.hash_input("banana") == %Identicon.Image{hex:
    [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]}
  end

  test "banana color" do
    # assert Identicon.pick_color(%Identicon.Image{hex:
    # [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]}) == [114, 179,2]
  end

  test "convert transistor" do
    assert Identicon.hash_input("transistor") == %Identicon.Image{hex:
    [170, 160, 215, 138, 244, 154, 47, 188, 47, 122, 216, 251, 177, 29, 225, 170]}
  end

  test "transistor color" do
    # assert Identicon.pick_color(%Identicon.Image{hex:
    # [170, 160, 215, 138, 244, 154, 47, 188, 47, 122, 216, 251, 177, 29, 225, 170]}) == [170, 160, 215]
  end

  test "mirror 114, 179, 2" do
    assert Identicon.mirror_row([114, 179, 2]) == [114, 179, 2, 179, 114]
  end

  test "mirror 170, 160, 215" do
    assert Identicon.mirror_row([170, 160, 215]) == [170, 160, 215, 160, 170]
  end
end
