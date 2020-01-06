require "spec_helper"
require "date"
RSpec.describe DailyLog::Day do

  subject { DailyLog::Day.new(Date.today) }

  describe "#to_s" do

    it "matches the format YY-MM-DD" do
      expect(subject.to_s).to eql(Date.today.strftime("%Y-%m-%d"))
    end

  end

  describe "#today?" do

    subject { DailyLog::Day.new(Date.today).today? }

    context "when date is today" do

      it { is_expected.to be_truthy }

    end


    context "when date is not today" do

      subject { DailyLog::Day.new(Date.new(2019, 05, 06)).today? }

      it { is_expected.to be_falsey }

    end

  end

end
