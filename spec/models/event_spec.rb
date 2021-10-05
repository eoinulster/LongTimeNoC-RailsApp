require 'rails_helper'

RSpec.describe Event, type: :model do
    let(:event_with_no_date) { Event.new({:date => "", :user => FactoryBot.build(:user)}) }
    let(:event_with_no_user) { Event.new({:date => Time.now}) }


    it 'validates presence of date' do
        expect(event_with_no_date).not_to be_valid
    end

    it 'validates presence of user' do
        expect(event_with_no_user).not_to be_valid
    end


    it 'validates event user and contact user are same'
    it 'assigns potential_contacts'

    it 'calling time returns string of hour and minute' do
        e = Event.new
        e.date = Time.zone.parse('2007-02-10 15:30:45')
        expect(e.time).to eq("15:30")
    end

    describe 'associations' do
        it { should belong_to(:user)}
        it { should have_many(:attendeds)}
        it { should have_many(:closecontacts)}


    end
end
