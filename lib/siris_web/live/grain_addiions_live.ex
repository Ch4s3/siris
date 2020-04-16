defmodule SirisWeb.GrainAdditionsLive do
  @moduledoc false

  require Logger
  use Phoenix.LiveView
  alias Siris.Ingredients
  alias Siris.Recipes
  import ScoutApm.Tracing
end
