defmodule And do

  # Unir los mapas sin generar conflictos con Map.merge
  defp join([]), do: Map.new()
  defp join([head|tail]) do
    Map.merge(head, join(tail))
  end

  # Definir transiciones válidas
  defp correct_trans(aut, actual, check, delta) do
    check = check ++ [actual]
    aut.delta
    |> Enum.filter(fn {{child, _}, _} -> child == actual end)
    |> Enum.map(fn {{actual, simbology}, post} ->
      if(post not in check) do
        correct_trans(aut, post, check, Map.put(delta, {actual, simbology}, post))
      else
        Map.put(delta, {actual, simbology}, post)
      end
    end)
  end

  # Crear el nuevo delta
  def gen_delta(n) do
    statesb = autondf(n.states)
    deltav =
    for estado <- statesb, transicion <- n.alpha do
      {{estado, transicion},
        Enum.map(estado, fn conjunto -> n.delta[{conjunto, transicion}] end)
        |> List.flatten
      }
    end
    {statesb, deltav}
  end

  # Realizar recorrido por profundidad
  def autondf([]), do: [[]]
  def autondf([head|tail])do
    rsduo = autondf(tail)
    autondf(head,rsduo,rsduo)
  end

  defp autondf(_, [], acum), do: acum
  defp autondf(val, [head|tail], acum), do: autondf(val,tail, [[val|head] | acum])

  #Funcion para podar el grafo y solo llegar a los estado scorrectos
  def prune(aut) do
    inicio = aut.initstate
    delta = correct_trans(aut, inicio, [], Map.new())|> List.flatten() |> join()

    statesb = Enum.map(delta, fn {{state1, _}, state2} -> [state1] ++ [state2] end)
    |> Enum.concat() |> Enum.uniq() |> Enum.sort()

    finals = Enum.filter(aut.finalstates, fn fin -> fin in statesb end)
    |> Enum.uniq()

    %{%{%{aut|delta: delta}|states: statesb}|finalstates: finals}
  end

  # Funcion para convertir un automata finito no determinista a un automata finito determinista
  def determinize(auto) do
    {statesb,delt} = gen_delta(auto)
    %{
      alpha: auto.alpha,
      states: statesb,
      initstate: [auto.initstate],
      finalstates: Enum.filter(statesb, fn x -> Enum.any?(x, fn as -> as in auto.finalstates end) end),
      delta: delt |> Map.new()
    }
  end

end
