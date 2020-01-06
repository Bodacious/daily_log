module DailyLog

  # Finds the latest past Date that we have an Entry for in the local filesystem
  class LatestDate

    ##
    # Match a file path to extract a date component
    DATE_PATH_MATCHER = /(?<year>\d{4})\/(?<month>\d{2})\/(?<day>\d{2})/

    # The latest entry in the local file system
    #
    # Returns Date
    # Returns nil
    def find
      return nil unless entry_paths.any?
      past_entries = entry_paths.map do |path|
        match = path.match(DATE_PATH_MATCHER)
        Date.parse(match.to_s)
      end.select { |date| date < today }

      past_entries.last
    end

    # Convert the Date to a String
    # Returns String
    def to_s
      find.to_s.strftime(Day::DATE_FORMAT)
    end

    # Return the Date as a Date object
    def to_date
      find
    end

    private

    def today
      @today = Date.today
    end

    def entry_paths
      Dir[File.join(Pathname.dirname, "**", "*.md")].sort
    end

  end
end
