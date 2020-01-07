# frozen_string_literal: true

module DailyLog
  class Options
    require "optparse"
    require "optparse/date"
    require "date"

    attr_reader :hash

    alias to_hash hash

    def initialize
      @hash = defaults
      parse
    end

    def defaults
      { date: Date.today }
    end

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
