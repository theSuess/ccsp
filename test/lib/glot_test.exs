defmodule Ccsp.GlotTest do
  use ExUnit.Case, async: true
  alias Ccsp.Glot.Request
  alias Ccsp.Glot.Response

  @exampleProgram %Request{files: [%Request.File{name: "main.py", content: "print(42)"}]}

  test "run simple python example" do
    assert Ccsp.Glot.runprogramm("python/latest",@exampleProgram).body == %Response{stdout: "42\n", stderr: "", error: ""}
  end

  test "run a testcase" do
    assert Ccsp.Glot.runtestcase("python/latest",@exampleProgram,"42","42\n\n")
  end
end
