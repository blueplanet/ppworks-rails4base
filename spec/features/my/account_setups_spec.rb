require 'rails_helper'

describe 'My/Setups' do

  feature '/' do
    background do
      sign_in(user)
      visit root_path
    end

    context 'when a user has not set up own profile' do
      let(:user) { create(:user, :has_not_setup) }
      let(:new_user) { build(:user) }

      scenario 'redirect to setup page' do
        expect(current_path).to eq my_account_setup_path
      end

      scenario 'fill profile' do
        find('#user_name').set(new_user.name)
        find("#edit_user_#{user.id} input[type=submit]").click()
        within '.navbar' do
          expect(page).to have_content(new_user.name)
        end

        visit root_path
        expect(current_path).to eq root_path
      end
    end

    context 'when a user has set up own profile' do
      let(:user) { create(:user) }

      scenario "doesn't redirect" do
        expect(current_path).to eq root_path
      end
    end
  end
end
