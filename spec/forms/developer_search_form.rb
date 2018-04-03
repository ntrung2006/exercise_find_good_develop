# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeveloperSearchForm do
  describe '#search' do
    before do
      @devs = Developer.create([{ email: 'trung@gmail.com' }, { email: 'test@gmail.com' }])
      @pro_lang = ProgrammingLanguage.create([{ name: 'Ruby' }, { name: 'PHP' }])
      @lang = Language.create([{ code: 'en' }, { code: 'ja' }])

      @dev_lang = DeveloperLanguage.create([{ language_id: @pro_lang.first.id, developer_id: @devs.first.id }])
      @dev_pro_lang = DeveloperProgrammingLanguage.create([{ programming_language_id: @pro_lang.first.id, developer_id: @devs.first.id }])

    end

    context 'with no params' do
      it 'returns all users' do
        res = DeveloperSearchForm.new
        expect(res.search.size).to eq(2)
      end
    end

    context 'with both programming_language and language params' do
      it 'return result where dev know Ruby and English' do
        res = DeveloperSearchForm.new({pro_lang: @pro_lang.first.id, lang: @lang.first.id})
        expect(res.search.size).to eq(1)
      end

      it 'return no result where dev know Ruby and Japan language' do
        res = DeveloperSearchForm.new({pro_lang: @pro_lang.first.id, lang: @lang.last.id})
        expect(res.search.size).to eq(0)
      end
    end
  end
end
