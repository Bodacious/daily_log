# frozen_string_literal: true

module DailyLog

  # Represents one calendar Day
  class Day

    ##
    # Format for dates when printed as stringss
    DATE_FORMAT  = "%Y-%m-%d"

    ##
    # The Date object for this Day
    attr_reader :date

    ##
    # Create a new day
    #
    # date - A valid Date object
    def initialize(date)
      @date = date
    end

    # Is this Day today's calendar Date?
    #
    # Returns Boolean
    def today?
      @date == Date.today
    end

    # Print the date as a formatted string
    #
    # Returns String
    def to_s
      date.strftime(DATE_FORMAT)
    end

  end
end
