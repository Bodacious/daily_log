# frozen_string_literal: true

module DailyLog

  # The pathname for an Entry file on a given Day
  class Pathname
    require "forwardable"
    require "zero_padded"

    extend Forwardable
    using ZeroPadded

    ##
    # The default name for the dir where entries are stored.
    DEFAULT_DIRNAME = ".daily_logs"

    ##
    # The default format for entries
    FORMAT = "md"

    ##
    # The Date we're caluclating the Pathname for
    attr_reader :date

    def_delegators :date, :year, :month, :day

    class << self

      ##
      # Set the dirname where entries are stored
      attr_writer :dirname

      ##
      # The dirname where entries are stored
      #
      # Returns String
      def dirname
        @dirname || DEFAULT_DIRNAME
      end

    end

    # Create a new Pathname
    #
    # date - The Date we're creating a Pathname for
    def initialize(date)
      @date = date
    end

    # The Pathname as a path string
    # Returns String
    def to_path
      File.join(dirname, "#{day.zero_pad}.#{FORMAT}")
    end

    alias to_s to_path

    # The name of the directory where the Entry will live
    #
    # Returns String
    def dirname
      File.join self.class.dirname, year.zero_pad, month.zero_pad
    end

  end
end
