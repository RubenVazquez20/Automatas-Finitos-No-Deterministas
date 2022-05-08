defmodule And_f do

  def a1 do
    %{
      alpha: ~w[a b],
      states: [P0,P1,P2,P3],
      istate: P0,
      fstates: [P3],
      delta: %{
        {P0, "a"} => [P0,P1],
        {P0, "b"} => [P0],
        {P1, "a"} => [],
        {P1, "b"} => [P2],
        {P2, "a"} => [],
        {P2, "b"} => [P3],
        {P3, "a"} => [],
        {P3, "b"} => [],
      }
    }
  end

  def e do
    %{
      alpha: ~w[a b],
      states: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10],
      istate: P0,
      fstates: [P10],
      delta: %{
        {P0, nil} => [P1, P7],
        {P1, nil} => [P2, P3],
        {P2, "a"} => [P4],
        {P3, "b"} => [P5],
        {P4, nil} => [P6],
        {P5, nil} => [P6],
        {P6, nil} => [P1, P7],
        {P7, "a"} => [P8],
        {P8, "b"} => [P9],
        {P9, "b"} => [P10]
      }
    }
  end
end
