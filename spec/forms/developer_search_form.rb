# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeveloperSearchForm do
  describe '#search' do

    let(:language) { create :language }
    let(:programming_language) { create :programming_language }

    before do
      create(:developer, programming_languages: [programming_language], languages: [language])
      create :developer
    end

    context 'with no params' do
      it 'returns all users' do
        developer_search_form = DeveloperSearchForm.new
        expect(developer_search_form.search.size).to eq(2)
      end
    end

    context 'with params' do
      it 'returns developers know a Programming Language.' do
         developer_search_form = DeveloperSearchForm.new(programming_language_id: programming_language.id)
        expect(developer_search_form.search.size).to eq(1)
      end

      it 'returns developers know a Language.' do
         developer_search_form = DeveloperSearchForm.new(language_id: language.id)
        expect(developer_search_form.search.size).to eq(1)
      end

      it 'return one result where dev know language and programming language' do
         developer_search_form = DeveloperSearchForm.new({programming_language_id: programming_language.id, language_id: language.id})
        expect(developer_search_form.search.size).to eq(1)
      end

      it 'No result where dev know Programming Language but do not kow language.' do
         developer_search_form = DeveloperSearchForm.new({programming_language_id: programming_language.id, language_id: 99})
        expect(developer_search_form.search.size).to eq(0)
      end
    end
  end
end
