defmodule Ccsp.Glot do
  use HTTPoison.Base
  defmodule Request do
    @derive [Poison.Encoder]
    defmodule Files do
      @derive [Poison.Encoder]
      defstruct [:content,:name]
    end
    defstruct [:files]
  end


  defmodule Response do
    @derive [Poison.Encoder]
    defstruct [:stdout, :stderr, :error]
  end

  def runprogramm(language,programm) do
    prg = Poison.encode! programm
    post!(language,prg)
  end

  def process_url(url) do
    "https://run.glot.io/languages/" <> url
  end

  def process_request_headers(headers) do
    token = Application.get_env(:ccsp,:glot_token)
    headers
    |> Dict.put(:"Authorization", "Token " <> token) # TODO: Use Map.put (cant figure out how...)
    |> Dict.put(:"Content-Type", "application/json")
  end

  def process_response_body(body) do
    body
    |> Poison.decode!(as: %Response{})
  end

end

