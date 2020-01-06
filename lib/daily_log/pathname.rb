module DailyLog
  class Pathname
    require "forwardable"
    require "zero_padded"

    extend Forwardable
    using ZeroPadded

    DEFAULT_DIRNAME = ".daily_logs"

    FORMAT = "md"

    attr_reader :date

    def_delegators :date, :year, :month, :day

    class << self

      attr_writer :dirname

      def dirname
        @dirname || DEFAULT_DIRNAME
      end

    end


    def initialize(date)
      @date = date
    end

    def to_s
      to_path.to_s
    end

    def to_path
      File.join(dirname, "#{day.zero_pad}.#{FORMAT}")
    end

    def dirname
      File.join self.class.dirname, year.zero_pad, month.zero_pad
    end

  end
end
