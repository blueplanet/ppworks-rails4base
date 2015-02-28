require 'rails_helper'

describe User do
  let(:connection) { build(:connection) }
  let(:user) { create(:user, connections: [connection]) }
  let(:valid_auth_hash) {
    {
      'provider' => 'developer',
      'uid' => '123456',
      'info' => {
        'nickname' => 'ppworks',
        'name' => 'PP works',
        'image' => 'http://a0.twimg.com/profile_images/2900491556/9d2bf873770958647f18b8e61af31f1a_normal.png'
      },
      'credentials' => {
        'token' => '123445678-AbeafjabutWjfav932m38e3TTabbbbbk',
        'secret' => 'UzOc15tGx8AMYLOX5dcZ2UQTEwe6LiVysdoyhiKlaw'
      }
    }
  }

  describe '#create' do
    subject { user }
    it { expect(subject).to be_instance_of(User) }
  end

  describe 'relations' do
    it { should have_many(:connections) }
  end

  describe 'create user with no email & password' do
    let(:user) { build(:user, email: nil, password: nil) }
    context 'when include OauthSignupable' do
      it do
        expect {
          user.save
        }.to change(User, :count).by(0)
      end
    end

    context 'when not include OauthSignupable' do
      it do
        expect {
          user.extend OauthSignupable
          user.save
        }.to change(User, :count).by(1)
      end
    end
  end

  describe '.authentication' do
    let(:auth_hash) { nil }
    let(:current_user) { nil }
    subject { User.authentication(auth_hash, current_user) }

    context 'when not exist auth_hash' do
      it { should be_nil }
    end

    context 'when exists auth_hash' do
      let(:auth_hash) { valid_auth_hash }

      context 'if signed in' do
        let(:current_user) { user }
        context 'and the user has connection' do
          let(:connection) { build(:connection) }
          before do
            user.connections << connection
          end
          it { should eq user }
          it { should be_instance_of User }
        end

        context 'and the user has not connection' do
          it { should eq user }
          it { should be_instance_of User }
        end
      end

      context 'if not signed in' do
        context 'and the user has connection' do
          before do
            connection = user.connections.last
            connection.uid = auth_hash['uid']
            connection.save
          end
          it { should eq user }
          it { should be_instance_of User }
        end

        context 'and the user has not connection' do
          let!(:new_user) { build(:user) }
          before do
            allow(User).to receive(:new).and_return(new_user)
          end
          it { should eq new_user }
          it { should be_instance_of User }
        end
      end
    end
  end

  describe '#me?' do
    subject { user.me?(whoami) }

    context 'me' do
      let(:whoami) { user }
      it { should be_truthy }
    end

    context 'other' do
      let(:whoami) { create(:user) }
      it { should be_falsey }
    end
  end
end
