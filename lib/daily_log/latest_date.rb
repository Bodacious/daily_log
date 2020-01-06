module DailyLog
  class LatestDate

    def find
      return nil unless entry_paths.any?
      past_entries = entry_paths.map do |path|
        match = path.match(/(?<year>\d{4})\/(?<month>\d{2})\/(?<day>\d{2})/)
        Date.parse(match.to_s)
      end.select { |date| date < today }

      past_entries.last
    end

    def to_s
      find.to_s.strftime(Day::DATE_FORMAT)
    end

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
