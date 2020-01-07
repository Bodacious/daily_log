# frozen_string_literal: true

module DailyLog

  # Parses options passed into the command-line and returns the desired values
  class Options
    require "optparse"
    require "optparse/date"
    require "date"

    ##
    # The options as a Hash
    #
    # Returns Hash
    attr_reader :hash

    alias to_hash hash

    def initialize
      @hash = defaults
      parse
    end

    # The default options
    #
    # Returns Hash
    def defaults
      { date: Date.today }
    end

    # Parse the input options and update the {hash} with desired values.
    def parse
      OptionParser.new do |opts|
        opts.banner = "Usage: dl [options]"
        opts.on("-e", "--edit", "Open the entry in the editor",
                                "(Even when it's not today's date)") do
          hash[:edit] = true
        end
        opts.on("", "--path", "Show the path for the given entry file") do
          hash[:path] = true
        end
        opts.on("-p", "--print", "Print the entry to STDOUT",
                                "(Even when it's today's date)") do
          hash[:print] = true
        end
        opts.on("-d", "--date=DATE", Date, "Date to show string for") do |date|
          hash[:date] = date
        end
        opts.on("-l", "--last", "Show the last daily log entry") do |dh|
          last = DailyLog::LatestDate.new.find
          if last
            hash[:date] = last
          else
            puts "There are no previous entries"
          end
        end
      end.parse!
      hash[:print] = (hash[:date] != Date.today) unless hash.key?(:print)
      hash[:edit]  = (hash[:date] == Date.today) unless hash.key?(:edit)
    end
  end
  
end
