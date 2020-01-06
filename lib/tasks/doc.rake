namespace :doc do

  desc "Create the HTML docs for this project"
  task :create do
    load("lib/daily_log/version.rb")
    system("yard doc --plugin tomdoc\
                     --hide-void-return\
                     --title \"Daily Logs - #{DailyLog::VERSION}\"")
  end
end

task doc: ["doc:create"]
