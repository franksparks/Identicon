defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  This program would ingest a string and turn it into a 5x5 squares identicon.
  Mirrored on the center.

  It will not be randomly generated, as the string will be converted into the identicon.
  Introducing the same string, the same identicon should be generated.

  By doing so, there is no need to store the image, as the identicon can be generated every time on the fly.
  """

  @doc """
  Main method consists on a pipeline, which processes the original string `input`, and transforms it several times until the identicon is generated.

  1.- `input` will be set as the first argument on the pipeline.
  2.- `hash_input` method will be triggered, to transform the `input` string into a 15 numers string.
  3.-
  """
  def main(input) do
    input
    |> hash_input
  end

  @doc """
  `Hash_input` function converts a given `input` into a MD5 hash, and then transforms that unique numbers into a string of 15 numbers, using the pipe operator.

  ## Example 1

      iex>Identicon.hash_input("banana")
      [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]

  ## Example 2
      iex>Identicon.hash_input("transistor")
      [170, 160, 215, 138, 244, 154, 47, 188, 47, 122, 216, 251, 177, 29, 225, 170]

  """
  def hash_input(input) do
    :crypto.hash(:md5,input)
    |> :binary.bin_to_list
  end

end