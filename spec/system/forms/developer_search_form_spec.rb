# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Developer search', type: :system do

  before do
    @devs = Developer.create([{ email: 'trung@gmail.com' }, { email: 'test@gmail.com' }])
    @pro_lang = ProgrammingLanguage.create([{ name: 'Ruby' }, { name: 'PHP' }])
    @lang = Language.create([{ code: 'en' }, { code: 'ja' }])

    @dev_lang = DeveloperLanguage.create([{ language_id: @pro_lang.first.id, developer_id: @devs.first.id }])
    @dev_pro_lang = DeveloperProgrammingLanguage.create([{ programming_language_id: @pro_lang.first.id, developer_id: @devs.first.id }])

  end

  it 'Search first load page' do
    visit developers_path
    expect(page).to have_content 'Developers'
    expect(page).to have_content('trung@gmail.com')
    expect(page).to have_content('en')
  end

  it 'Search no select language and programming language' do
    visit developers_path
    expect(page).to have_content 'Developers'
    click_on 'Search'
    expect(page).to have_content('trung@gmail.com')
    expect(page).to have_content('en')
  end

  it 'Search Dev know programming language Ruby' do
    visit developers_path
    expect(page).to have_content 'Developers'
    select 'Ruby', from: 'developer_search_form_pro_lang'
    click_on 'Search'
    expect(page).to have_content('trung@gmail.com')
  end

  it 'Search Dev know both Ruby and English' do
    visit developers_path
    expect(page).to have_content 'Developers'
    select 'Ruby', from: 'developer_search_form_pro_lang'
    select 'en', from: 'developer_search_form_lang'
    click_on 'Search'
    expect(page).to have_content('trung@gmail.com')
  end

  it 'Search Dev know PHP and Japanes' do
    visit developers_path
    expect(page).to have_content 'Developers'
    select 'PHP', from: 'developer_search_form_pro_lang'
    select 'ja', from: 'developer_search_form_lang'
    click_on 'Search'
    expect(page).to have_no_content('trung@gmail.com')
  end
end
# rubocop:enable