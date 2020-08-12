class App

  def call(env)
    [200, {"Content-Type" => 'text/plain'}, ["OK\n"]]
  end

end
