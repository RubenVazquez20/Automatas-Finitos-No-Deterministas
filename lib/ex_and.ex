defmodule And_f do

  def and1 do
    %{
      alpha: ~w[a b],
      states: [E0,E1,E2,E3],
      initstate: E0,
      finalstates: [E3],
      delta: %{
        {E0, "a"} => [E0,E1],
        {E0, "b"} => [E0],
        {E1, "a"} => [],
        {E1, "b"} => [E2],
        {E2, "a"} => [],
        {E2, "b"} => [E3],
        {E3, "a"} => [],
        {E3, "b"} => [],
      }
    }
  end

  def and2 do
    %{
      alpha: ~w[a b],
      states: [E0, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10],
      initstate: E0,
      finalstates: [E10],
      delta: %{
        {E0, nil} => [E1, E7],
        {E1, nil} => [E2, E3],
        {E2, "a"} => [E4],
        {E3, "b"} => [E5],
        {E4, nil} => [E6],
        {E5, nil} => [E6],
        {E6, nil} => [E1, E7],
        {E7, "a"} => [E8],
        {E8, "b"} => [E9],
        {E9, "b"} => [E10]
      }
    }
  end
end
