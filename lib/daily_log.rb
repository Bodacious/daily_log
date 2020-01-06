# frozen_string_literal: true


module DailyLog
  require_relative "daily_log/options"
  require_relative "daily_log/latest_date"
  require_relative "daily_log/scm_check"
  require_relative "daily_log/day"
  require_relative "daily_log/entry"
  require_relative "daily_log/pathname"

  module_function

  def open_or_print(options = {})
    @day   = Day.new(options[:date])
    @entry = Entry.new(@day)
    puts "options: #{options}"
    @entry.print if options[:print]
    @entry.open  if options[:edit]
  end

end
