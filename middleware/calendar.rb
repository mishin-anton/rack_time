require 'date'

class Calendar

  def initialize(app)
    @app = app
    @supported_formats = ['year', 'month', 'day', 'hour', 'minute', 'second']
  end

  def call(env)
    status, headers, body = @app.call(env)

    @req = Rack::Request.new(env)
    @response = Rack::Response.new

    routes(env)
  end

  def routes (env)
    case @req.path_info
    when /time/
      time_handler(env)
    else
      not_found
    end
  end

  private

  def not_found
    [404, {"Content-Type" => 'text/plain'}, ["Not found"]]
  end

  def time_handler(env)
    if accepted_format?
      [200, {"Content-Type" => 'text/plain'}, ["#{get_data}"]]
    else
      [400, {"Content-Type" => 'text/plain'}, ["Unknown time format #{unknow_params}"]]
    end
  end

  def accepted_format?
    final = get_params - @supported_formats

    final.empty?
  end

  def unknow_params
    get_params - @supported_formats
  end

  def get_data
    params = get_params

    data_convertor(params)
  end

  def get_params
    formats = @req.params
    formats = split_params(formats)
  end

  def data_convertor(params)
    current_time = Time.new
    year = ''
    month = ''
    day = ''
    hour = ''
    minute = ''
    second = ''
    undefined = 0
    undefined_array = []

    params.map! do |value|
      case value
      when 'year'
        value = current_time.year
      when 'month'
        value = current_time.month
      when 'day'
        value = current_time.day
      when 'hour'
        value = current_time.hour
      when 'minute'
        value = current_time.min
      when 'second'
        value = current_time.sec
      end
    end

    params.join("-")
  end

  def split_params (params)
    str = ''
    params.each do |format, value|
      str = value.split(',')
    end

    str
  end

end
