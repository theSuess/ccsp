defmodule Ccsp.Glot do
  use HTTPoison.Base
  alias Ccsp.Repo
  alias Ccsp.Testcase

  defmodule Request do
    @derive [Poison.Encoder]
    defmodule File do
      @derive [Poison.Encoder]
      defstruct [:content,:name]
    end
    defstruct [:files,:stdin]
  end


  defmodule Response do
    @derive [Poison.Encoder]
    defstruct [:stdout, :stderr, :error]
  end

  def runprogramm(language,program) do
    prg = Poison.encode! program
    post!(language,prg)
  end

  def runtestcase(language,program,input,output) do
    prg = %{program | :stdin => input}
    String.trim(runprogramm(language,prg).body.stdout) == String.trim(output)
  end

  def runtestcases(language,program,id) do
    testcases = Testcase
    |> Testcase.ordered(id)
    |> Repo.all()
    |> Repo.preload(:challenge)
    Enum.map(testcases, fn x -> runtestcase(language,program,x.input,x.output) end)
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

