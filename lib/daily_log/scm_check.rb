# frozen_string_literal: true

module DailyLog

  # Source-Code management check. Make sure the entries aren't being checked
  # into Git.
  # # TODO: Allow devs to disable this in as an option
  # # TODO: Allow devs to disable this in a .daily_log file
  # # TODO: Add support for other SCM
  class ScmCheck

    # Perform the check. Print to STDOUT if there is a warning
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
      File.read(".gitignore").include?(DailyLog::Pathname::dirname)
    end

  end
end
