class TimeFormatter

  def initialize (current_format)
    @current_format = current_format
    @supported_formats = ['year', 'month', 'day', 'hour', 'minute', 'second']
  end

  def accepted_format?
    accepted_format = @current_format - @supported_formats
    accepted_format.empty?
  end

  def unknow_params
    @current_format - @supported_formats
  end

  def get_data
    data_convertor(@current_format)
  end

  def data_convertor(current_format)
    current_time = Time.new
    @dates = ''

    @current_format.map! do |value|
      case value
      when 'year'
        @dates = @dates + "%Y"
      when 'month'
        @dates = @dates + "%m"
      when 'day'
        @dates = @dates + "%d"
      when 'hour'
        @dates = @dates + "%h"
      when 'minute'
        @dates = @dates + "%M"
      when 'second'
        @dates = @dates + "%s"
      end
    end

    @dates = @dates.split('').join("-")
    Time.now.strftime(@dates)

  end

  def getTime

  end

end
