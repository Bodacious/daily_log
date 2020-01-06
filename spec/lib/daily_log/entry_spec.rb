# frozen_string_literal: true

require 'spec_helper'
require 'date'
RSpec.describe DailyLog::Entry do
  let(:date) { Date.new(2020, 0o1, 0o1) }

  let(:day) { DailyLog::Day.new(date) }

  let(:entry) { DailyLog::Entry.new(day) }

  before(:all) do
    DailyLog::Pathname.dirname = 'tmp/spec'
  end

  after do
    FileUtils.rm_rf('tmp/spec')
  end

  after(:all) do
    DailyLog::Pathname.dirname = nil
  end

  describe '#print' do
    subject { entry.print }

    context 'when the file exists' do
      before do
        expect(entry).to receive(:open_in_editor).and_return(true)
        entry.open
      end

      it 'prints the file content' do
        expect { subject }.to output(/template/i).to_stdout
      end
    end

    context "when the file doesn't exist" do
      it 'prints a warning message' do
        expect { subject }.to output(/No file/).to_stdout
      end
    end
  end

  describe '#open' do
    subject { entry.open }

    before do
      expect(entry).to receive(:open_in_editor).and_return(true)
    end

    context 'when the file exists' do
      it 'opens the local text editor' do
        subject
      end
    end

    context "when the file doesn't exist" do
      it 'creates the dirs' do
        subject
        expect(Dir.exist?(entry.pathname.dirname)).to be_truthy
      end

      it 'opens the local text editor' do
        subject
      end
    end
  end
end
