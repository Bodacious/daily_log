# frozen_string_literal: true


module DailyLog
  require "scm_check"
  require "day"

  DIRNAME = ".daily_logs"
  DATE_FORMAT  = "%Y-%m-%D"
  
  module_function

  def scm_check!
    ScmCheck.new.perform!
  end

  def open(**options)
    @day.open
  end

  def print
    @day.print
  end

  def open_or_print(**options)
    @day = Day.new(options)
    if @day.today? or options[:edit]
      open
    else
      print
    end
  end

end
