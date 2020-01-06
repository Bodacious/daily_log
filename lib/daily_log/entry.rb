# frozen_string_literal: true

module DailyLog
  # One Daily Log journal Entry
  #
  class Entry
    require 'erb'
    require "fileutils"

    ##
    # The Day this Entry is for
    attr_reader :day

    ##
    # The Pathname of the file to the Entry
    attr_reader :pathname


    ##
    # Default path for the daily entry Markdown template
    TEMPLATE_PATH = File.join(File.dirname(__FILE__), '..', '..',
                              'lib/templates/daily_log/entry.md.erb')


    # Create a new Entry
    #
    # day - The Day we're creating a new Entry for
    def initialize(day)
      @day = day
      @pathname = Pathname.new(day.date)
    end

    # Print the contents of this Entry to STDOUT. If no entry exists, print a
    # warning.
    def print
      if exists?
        puts file.read
      else
        puts "No file exists for date: #{@day}"
      end
    end

    # Open the Entry file in the text editor. If one doens't already exist,
    # create it for this Day
    def open
      ensure!
      open_in_editor
    end

    private

    def open_in_editor
      exec("$EDITOR -w #{pathname}")
    end

    def file
      @file ||= File.open(pathname, 'r')
    end

    def local_template_path
      "./#{Pathname.dirname}/templates.md.erb"
    end

    def template_path
      if local_template_exists?
        local_template_path
      else
        TEMPLATE_PATH
      end
    end

    def local_template_exists?
      File.exist?(local_template_path)
    end

    def exists?
      File.exist?(pathname)
    end

    def ensure!
      return if exists?
      FileUtils.mkdir_p(pathname.dirname)
      template = ERB.new File.read(template_path)
      File.open(pathname.to_s, "wb") do |file|
        file.write template.result(binding)
      end
    end
  end
end
