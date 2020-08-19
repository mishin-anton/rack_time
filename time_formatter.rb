class TimeFormatter

  SUPPORTED_FORMATS = {'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H',
   'minute' => '%m', 'second' => '%S'}

  def initialize (current_format)
    @current_format = current_format
  end

  def call
    @difference = @current_format - SUPPORTED_FORMATS.keys
  end

  def accepted_format?
    call.empty?
  end

  def unknow_params
    @difference
  end

  def time_result
    data = @current_format.reduce('') { |body_box, param| body_box << SUPPORTED_FORMATS[param] }
    data = data.split('').join('-')
    Time.now.strftime(data)
  end

end
