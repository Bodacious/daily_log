# frozen_string_literal: true

module DailyLog
  class Day
    require "forwardable"
    require "erb"

    extend Forwardable

    attr_reader :date

    def_delegators :date, :year, :month, :day

    def initialize(options)
      @date = options[:date]
    end

    def today?
      @date == Date.today
    end

    def exists?
      File.exist?(file_path)
    end

    def print
      if exists?
        puts File.read(filepath)
      else
        warn "No file exists for date: #{@date.to_s}"
      end
    end

    def open
      copy_template unless exists?
      exec("$EDITOR -w #{file_path}")
    end

    private

    def copy_template
      template = local_template || default_template

    end


    def file_path
      File.join(".", DailyLog::DIRNAME, zero_pad(year),
                zero_pad(month), "#{zero_pad(day)}.md")
    end

    def zero_pad(number)
      number.to_s.rjust(2, "0")
    end

  end
end
