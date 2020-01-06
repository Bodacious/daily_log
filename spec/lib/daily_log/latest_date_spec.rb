require "spec_helper"
require "date"
RSpec.describe DailyLog::LatestDate do

  before :all do
    DailyLog::Pathname.dirname = "tmp/spec"
  end

  after(:all) do
    DailyLog::Pathname.dirname = nil
  end

  after(:each) do
    FileUtils.rm_rf("tmp/spec")
  end

  describe "#find" do

    subject { DailyLog::LatestDate.new.find }

    context "when there are no entries available" do

      before do
        FileUtils.rm_rf("tmp/spec")
      end

      it { is_expected.to be_nil }

    end

    context "when there are entries available" do

      before do
        today = Date.today.strftime("%Y-%m")
        tomor = Date.today.next.strftime("%Y-%m")
        FileUtils.mkdir_p("tmp/spec/2019/01")
        FileUtils.mkdir_p("tmp/spec/2020/01")
        FileUtils.mkdir_p("tmp/spec/#{today}")
        FileUtils.mkdir_p("tmp/spec/#{tomor}")
        FileUtils.mkdir_p("tmp/spec/2050/01")
        FileUtils.touch("tmp/spec/2019/01/03.md")
        FileUtils.touch("tmp/spec/2020/01/03.md")
        FileUtils.touch("tmp/spec/2020/01/02.md")
        FileUtils.touch("tmp/spec/2050/01/02.md")
      end

      it "returns the latest date before today" do
        is_expected.to eql(Date.new(2020, 01, 03))
      end

    end

  end

end
