# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Developer search', type: :system do

  let(:language) { create :language }
  let(:programming_language) { create :programming_language }

  before do
    @developer = create(:developer, programming_languages: [programming_language], languages: [language])
    create :developer
    @language = create :language
  end

  it 'Search first load page' do
    visit developers_path
    expect(page).to have_content 'Developers'
    expect(page).to have_content(@developer.email)
    expect(page).to have_content(language.code)
  end

  it 'Search no select language and programming language' do
    visit developers_path
    expect(page).to have_content 'Developers'
    click_on 'Search'
    expect(page).to have_content(@developer.email)
    expect(page).to have_content(language.code)
  end

  it 'Search developer know programming language' do
    visit developers_path
    expect(page).to have_content 'Developers'
    select programming_language.name, from: 'developer_search_form_programming_language_id'
    click_on 'Search'
    expect(page).to have_content(@developer.email)
  end

  it 'Search developer know both programming language and language' do
    visit developers_path
    expect(page).to have_content 'Developers'
    select programming_language.name, from: 'developer_search_form_programming_language_id'
    select language.code, from: 'developer_search_form_language_id'
    click_on 'Search'
    expect(page).to have_content(@developer.email)
  end

  it 'Search have no content' do
    visit developers_path
    expect(page).to have_content 'Developers'
    select programming_language.name, from: 'developer_search_form_programming_language_id'
    select @language.code, from: 'developer_search_form_language_id'
    click_on 'Search'
    expect(page).to have_no_content(@developer.email)
  end
end
# rubocop:enable