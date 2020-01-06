# frozen_string_literal: true

require 'spec_helper'
require 'date'

RSpec.describe DailyLog::Pathname do
  using ZeroPadded

  describe '::dirname' do
    subject { DailyLog::Pathname.dirname }

    context 'when custom value set' do
      before do
        DailyLog::Pathname.dirname = './tmp'
      end

      after do
        DailyLog::Pathname.dirname = nil
      end

      it 'returns custom value' do
        expect(subject).to eql('./tmp')
      end
    end

    context 'when no custom value set' do
      it 'returns default value' do
        expect(subject).to eql('.daily_logs')
      end
    end
  end

  describe '#to_path' do
    subject { DailyLog::Pathname.new(Date.today).to_path }

    it 'returns a String object' do
      expect(subject).to be_a(String)
    end

    it 'includes the year dir, month dir, and date as filename' do
      year  = Date.today.year.zero_pad
      month = Date.today.month.zero_pad
      day   = Date.today.day.zero_pad

      expect(subject).to include("#{year}/#{month}/#{day}")
    end

    it 'has the correct dirname' do
      expect(subject).to start_with '.daily_logs'
    end

    it 'has the correct file extension' do
      expect(subject).to end_with('.md')
    end
  end
end
