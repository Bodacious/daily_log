# frozen_string_literal: true

module DailyLog
  class ScmCheck

    def initialize
    end

    def perform!
      return unless git_project?
      return if has_gitignore? && has_ignored_daily_logs?
      warn <<~TEXT
        You should add .daily_logs to your .gitignore file
      TEXT
    end

    private

    def git_project?
      Dir.exists?("./.git")
    end

    def has_gitignore?
      File.exists?("./.gitignore")
    end

    def has_ignored_daily_logs?
      File.read(".gitignore").include?(DailyLog::DIRNAME)
    end

  end
end
