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

  5.- `filter_odds_squares` removes the odd squares of the grid.

  6.- Finally, it draws the identicon.

  7.- And save the image.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
    This method stores the identicon generated.
  """
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  @doc """
    This function draws the identicon.
    It creates an empty image and then fills it according
    to the color and the location of the even squares.
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  @doc """
    In order to draw the grid, some calculations have to be done
  to pinpoint the different squares.
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map }
  end

  @doc """
    `filter_odd_squares` method filters the grid to return the even values.
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end
  @doc """
    This function processes the 15 first values of the image and tranfoms them into 25,
  following the given requirements.

    - To do so, first of all 'image' struct is accessed, in particular to the hex property,
  the list of 16 hex numbers.

    - That list is divided into several lists of 3 elements, discarting the last value.

    - `mirror_row` method is referenced to append the values to mirror every row.

    - Flattening the list of lists, one single list with the 25 values will be returned.

    - `Enum.with_index` gets every element in the list and returns a tuple with
  the element and its index.
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
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

    - By pattern matching, the first 3 values of `image` are stored.

    - The underscore on `_tail` avoid warning messages to be displayed due to
    the fact tail is not being used anywhere.

    - `color` returns a tuple with RGB.

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
