# frozen_string_literal: true

module DailyLog
  class Day

    DATE_FORMAT  = "%Y-%m-%d"

    attr_reader :date

    def initialize(date)
      @date = date
    end

    def today?
      @date == Date.today
    end

    def to_s
      date.strftime(DATE_FORMAT)
    end

  end
end
