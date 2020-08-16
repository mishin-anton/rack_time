require_relative 'time_formatter'

class App

  def call(env)
    @req = Rack::Request.new(env)
    @response = Rack::Response.new

    routes

    @response.to_a
  end

  private

  def routes
    case @req.path_info
    when /time/
      time_request_handler
    else
      answer(404, "Not found")
    end
  end

  def time_request_handler
    current_format = Rack::Utils.parse_nested_query(@req.query_string).values.join.split(",")
    time_formatter = TimeFormatter.new(current_format)

    if time_formatter.accepted_format?
      answer(200, time_formatter.get_data)
    elsif
      answer(400, time_formatter.unknow_params)
    end
  end

  def answer (status, body)
    @response.status = status
    @response.write(body)
  end

  def headers
    @response.headers({ 'Content-Type' => 'text/plain' })
  end

end
