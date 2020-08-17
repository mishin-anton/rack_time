class TimeFormatter

  SUPPORTED_FORMATS = {'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H',
   'minute' => '%m', 'second' => '%S'}

  def initialize (current_format)
    @current_format = current_format
  end

  def accepted_format?
    accepted_format = @current_format - SUPPORTED_FORMATS.keys
    accepted_format.empty?
  end

  def unknow_params
    @current_format - SUPPORTED_FORMATS
  end

  def get_data
    data = @current_format.reduce('') { |body_box, param| body_box << SUPPORTED_FORMATS[param] }
    data = data.split('').join('-')
    Time.now.strftime(data)
  end

end
