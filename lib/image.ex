defmodule Identicon.Image do
  @moduledoc """
  This module will hold our struct.
  """
  @doc """
  Is stores a list of numbers as a struct with the following properties:
  - `hex` (hexadecimal) -> with default value `nil`.
  - `color` -> color of the identicon.
  - `grid` -> values and index of the grid.
  - `pixel_map` -> tuple with the top left and bottom right location of the squares to fill.
  """
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
