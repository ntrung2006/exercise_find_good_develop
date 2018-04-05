# frozen_string_literal: true

namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate test data'
  task :generate_data, [:dev_num] => :environment do |_, args|
    get_args(args)

    create_programming_language
    create_language

    programming_languages = ProgrammingLanguage.all
    languages = Language.all

    @args[:dev_num].times do
      FactoryBot.create :developer,
                        programming_languages: programming_languages.sample(rand(1..4)),
                        languages: languages.sample(rand(1..3))
    end
  end
end

def create_programming_language
  return false if ProgrammingLanguage.find_by(name: 'ruby').present?

  %w[ruby javascript php kotlin].each do |name|
    FactoryBot.create :programming_language, name: name
  end
end

def create_language
  return false if Language.find_by(code: 'en').present?

  %w[en vn ja].each do |code|
    FactoryBot.create :language, code: code
  end
end

def get_args(args)
  @args = {}
  @args[:dev_num] = (args.users_num || 100).to_i
end
