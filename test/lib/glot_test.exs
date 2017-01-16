defmodule Ccsp.GlotTest do
  use ExUnit.Case, async: true
  alias Ccsp.Glot.Request
  alias Ccsp.Glot.Response

  @exampleProgram %Request{files: [%Request.Files{name: "main.py", content: "print(42)"}]}

  test "run simple python example" do
    assert Ccsp.Glot.runprogramm("python/latest",@exampleProgram).body == %Response{stdout: "42\n", stderr: "", error: ""}
  end
end
