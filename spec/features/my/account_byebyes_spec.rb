require 'rails_helper'

describe 'My/Byebyes' do
  let(:user) { create(:user) }

  feature 'byebye user', :js do
    background do
      sign_in(user)
      visit my_account_byebye_path
    end

    scenario 'withdraw' do
      find('.withdraw-btn').click()
      expect(page).to have_content(I18n.t('devise.registrations.destroyed'))
    end
  end
end
