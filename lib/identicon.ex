defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  This program would ingest a string and turn it into a 5x5 squares identicon.
  Mirrored on the center.

  It will not be randomly generated, as the string will be converted into the identicon.
  Introducing the same string, the same identicon should be generated.

  By doing so, there is no need to store the image, as the identicon can be
  generated every time on the fly.
  """

  @doc """
  Main method consists on a pipeline, which processes the original string
  `input`, and transforms it several times until the identicon is generated.

  1.- `input` will be set as the first argument on the pipeline.

  2.- `hash_input` method will be triggered, to transform the `input`
  string into a 16 numbers string.

  3.- `pick_color` uses the first 3 numbers of the string to set the color of
  the identicon, as RGB values.

  4.- `build_grid` transforms the 16 numbers list into a 5x5 matrix, mirroring
  values.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  @doc """
  This function processes the 15 first values of the image and tranfoms them into 25,
  following the given requirements.

  To do so, first of all 'image' struct is accessed, in particular to the hex property,
  the list of 16 hex numbers.

  That list is divided into several lists of 3 elements, discarting the last value.

  Finally, `mirror_row` method is referenced to append the values to mirror every row.
  """
  def build_grid(%Identicon.Image{hex: hex} = _image) do
    hex
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)
  end

  @doc """
  This function appends two values to the list, to mirror the values as per needed
  for the identicon.
  """
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  @doc """
    This function gets the first thee values of the string, the RGB values.

    By pattern matching, the first 3 values of `image` are stored.

    The underscore on `_tail` avoid warning messages to be displayed due to
    the fact tail is not being used anywhere.

    `color` returns a tuple with RGB.

  ## Example
      # iex>Identicon.pick_color(%Identicon.Image{hex:
      # [170, 160, 215, 138, 244, 154, 47, 188, 47, 122, 216, 251, 177, 29, 225, 170]})
      # [170, 160, 215]

  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  `Hash_input` function converts a given `input` into a MD5 hash, and then
  transforms that unique numbers into a string of 16 numbers, using the pipe operator.
  The string of numbers is returned as a struct.

  ## Example
      iex>Identicon.hash_input("transistor")
      %Identicon.Image{hex: [170, 160, 215, 138, 244, 154, 47, 188, 47, 122,
      216, 251, 177, 29, 225, 170]}
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5,input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end


end
