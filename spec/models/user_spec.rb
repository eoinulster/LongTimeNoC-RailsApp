require 'rails_helper'

describe User do
    let(:user_with_no_email) { User.new() }

    it 'validates presence of email' do
        expect(user_with_no_email).not_to be_valid
    end

    let(:user1) { User.new({:email=>"1", :password=>"no effect"}) }
    let(:user2) { User.new({:email=>"2", :password=>"also pointless"}) }

    it 'checks that we are using a default pw digest for all users in this poc app' do
        expect(user1.password_digest).to eq(user2.password_digest)
    end

    describe 'associations' do
        it { should have_many(:events)}
        it { should have_many(:closecontacts)}
    end

    it 'is valid when required attributes are present' do
        expect(FactoryBot.build(:user)).to be_valid
    end

    it 'returns correct user when pw does match' do
        @john = User.create({:email => "john", :password_digest=>"setpw"})
        expect(User.find_by_credentials("john","setpw")).to eq(@john)
    end

    it 'returns nil when pw does not match' do
        @john = User.create({:email => "john", :password_digest=>"setpw"})
        expect(User.find_by_credentials("john","wrongpw")).to be_nil
    end

    it 'resets session token when the method is called' do
        @john = User.create({:email => "john", :session_token => "cooltoken"})
        token = @john.session_token
        @john.reset_session_token!
        expect(@john.session_token).to_not eq(token)
    end

    it 'ensures session token is set when user is created' do
        user = FactoryBot.build(:user)
        assert(user.session_token.length > 0)
    end

context 'is invalid' do
    specify 'when email is blank' do
         expect(FactoryBot.build(:user, email: '')).not_to be_valid
     end
     specify 'when session is blank' do
         expect(FactoryBot.build(:user, session_token: '')).not_to be_valid
       end
       specify 'when password digest is blank' do
         expect(FactoryBot.build(:user, password_digest: '')).not_to be_valid
       end
       specify 'when email is already taken' do
           @user = User.create({:email => "newcomplete"})
           otheruser = @user.dup
           #must do below so that this test is confined to email unique validation
           otheruser.session_token = "different"
           expect(otheruser).not_to be_valid
       end
       specify 'when session token is already taken' do
           @user = User.create({:email => "john",:session_token => "123"})
           otheruser = @user.dup
           #must do below so that this test is confined to session token unique validation
           otheruser.email = "different"
           expect(otheruser).not_to be_valid
       end
     end
end
