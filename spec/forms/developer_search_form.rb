# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeveloperSearchForm do
  describe '#search' do
    before do
      @developers = Developer.create([{ email: 'trung@gmail.com' }, { email: 'test@gmail.com' }])
      @programming_languages = ProgrammingLanguage.create([{ name: 'Ruby' }, { name: 'PHP' }])
      @languages = Language.create([{ code: 'en' }, { code: 'ja' }])

      @developers.first.programming_languages.create(@programming_languages.first)
      @developers.first.languages.create(@languages.first)

    end

    context 'with no params' do
      it 'returns all users' do
        res = DeveloperSearchForm.new
        expect(res.search.size).to eq(2)
      end
    end

    context 'with both programming_language and language params' do
      it 'return result where dev know Ruby and English' do
        res = DeveloperSearchForm.new({programming_language_id: @programming_languages.first.id, language_id: @languages.first.id})
        expect(res.search.size).to eq(1)
      end

      it 'return no result where dev know Ruby and Japan language' do
        res = DeveloperSearchForm.new({programming_language_id: @programming_languages.first.id, language_id: @languages.last.id})
        expect(res.search.size).to eq(0)
      end
    end
  end
end
