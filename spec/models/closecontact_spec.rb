require 'rails_helper'

RSpec.describe Closecontact, type: :model do
  let(:closecontact_with_no_firstname) { Closecontact.new({:secondname => "May"}) }
  let(:closecontact_with_no_secondname) { Closecontact.new({:firstname => "Theresa"}) }


  it 'validates presence of firstname' do
      expect(closecontact_with_no_firstname).not_to be_valid
  end

  it 'validates presence of secondname' do
      expect(closecontact_with_no_secondname).not_to be_valid
  end

  describe 'associations' do
      it { should belong_to(:user)}
  end

  it 'is valid when required attributes are present' do
      expect(FactoryBot.build(:closecontact)).to be_valid
  end

  it 'returns correct closecontacts when user.closecontacts is called'

  it 'sets the -regular- attribute to false by default for a new closecontact' do
      cc = Closecontact.new({:firstname=> "Leo", :secondname => "Varadkar"})
      assert(cc.regular == false)
  end

  it 'has a method fullname which will return first and second name separated by a space' do
      cc = Closecontact.new({:firstname=> "Leo", :secondname => "Varadkar"})
      assert(cc.fullname == "Leo Varadkar")
  end

end
