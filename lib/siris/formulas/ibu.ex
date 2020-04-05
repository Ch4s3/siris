defmodule Siris.Formulas.Ibu do
  alias Siris.Recipes.HopAddition

  @doc ~S"""
  calculates the IBUs based on Tenseth's Formula

  ## Examples

      iex> addition = %Siris.Recipes.HopAddition{aa_rating: 6.4, ounces: 1.5, boil_time: 45}
      iex> Siris.Formulas.Ibu.calculate(addition, 5, 1.05)
      30.450559892122822

      iex> a_1 = %Siris.Recipes.HopAddition{aa_rating: 6.4, ounces: 1.5, boil_time: 45}
      iex> a_2 = %Siris.Recipes.HopAddition{aa_rating: 5.0, ounces: 1.0, boil_time: 15}
      iex> Siris.Formulas.Ibu.calculate([a_1, a_2], 5, 1.05)
      39.023323402324436

  """
  def calculate([%HopAddition{} | _] = additions, gal, wort_gravity) do
    Enum.reduce(additions, 0, fn addition, acc ->
      calculate(addition, gal, wort_gravity) + acc
    end)
  end

  def calculate(%HopAddition{} = addition, gal, wort_gravity) do
    mg_l_added_alpha_acids(addition.aa_rating, addition.ounces, gal) *
      bigness_factor(wort_gravity) *
      boil_time_factor(addition.boil_time)
  end

  def calculate([], _, _), do: 0

  @spec mg_l_added_alpha_acids(float, float, float) :: float
  def mg_l_added_alpha_acids(aa_rating, ounces_hops, gal) do
    adjusted_aa = aa_rating / 100

    (adjusted_aa * ounces_hops * 7490)
    |> Kernel./(gal)
  end

  @spec bigness_factor(float) :: float
  def bigness_factor(wort_gravity) do
    adjusted_gravity = wort_gravity - 1

    1.65 * :math.pow(0.000125, adjusted_gravity)
  end

  @spec boil_time_factor(number) :: float
  def boil_time_factor(minutes) do
    adjusted_min = -0.04 * minutes

    (1 - :math.pow(2.71828, adjusted_min)) / 4.15
  end
end
