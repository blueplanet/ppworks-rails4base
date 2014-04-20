require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  describe 'Create user' do
    subject { user }
    it { expect(subject).to be_instance_of(User) }
  end
end
