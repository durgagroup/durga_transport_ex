defmodule Durga.Transport do
  v1_mapping = [
    {0, :req, [:id, :module, :function, :args, :env]},
    {1, :res, [:id, :res]},
    {2, :error, [:id, :code, :message]},
    {3, :register, [:module, :function, :artiy, :env]},
    {4, :unregister, [:module, :function, :artiy, :env]},
    {5, :list, [:id]},
  ]

  def decode(<<1, msg :: binary>>) do
    msg
    |> :msgpack.unpack([format: :map])
    |> decode_msg()
  end

  for {code, name, args} <- v1_mapping do
    vars = Enum.map(args, &(Macro.var(&1, nil)))
    def encode({unquote(name), unquote_splicing(vars)}) do
      msg = :msgpack.pack([unquote(code), unquote_splicing(vars)])
      <<1, msg :: binary>>
    end

    defp decode_msg({:ok, [unquote(code), unquote_splicing(vars)]}) do
      {unquote(name), unquote_splicing(vars)}
    end
  end
end