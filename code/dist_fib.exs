defmodule Fibonacci do

  def fib(0), do: 1
  def fib(1), do: 1
  def fib(n), do: fib(n - 2) + fib(n - 1)

  def dist_fib do
    receive do
      {sender, num} ->
        send sender, fib(num)
    end
  end

  def spawn_fib(node, n) do
    id = Node.spawn_link(node, Fibonacci, :dist_fib, [])

    send id, {self, n}

    receive do
      result ->
        IO.puts "The result is #{result}"
    end
  end

end
