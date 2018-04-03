namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate test data'
  task :generate_data, [:dev_num] => :environment do |_, args|
    set_args(args)

    begin

      res_pro_langs = create_programming_language
      res_langs = create_language

      @args[:dev_num].times do
        email = loop do
          email = "#{Faker::Twitter.screen_name[0..14]}@tech.reapra.sg" # The method can return a word with more than 15 chars.
          break email unless Developer.exists?(email: email)
        end

        FactoryBot.create :developer, email: email,
                          programming_languages: res_pro_langs.sample(rand(1..4)),
                          languages: res_langs.sample(rand(1..3))

        puts "Developer just created: #{email}"
      end
    rescue
      puts "Data already exits, please check!"
    end
  end
end

def create_programming_language
  ProgrammingLanguage.create([{name: 'ruby'}, {name: 'javascript'}, {name: 'php'}, {name: 'kotlin'}])
end

def create_language
  Language.create([{code: 'en'}, {code: 'vn'}, {code: 'ja'}])
end

def set_args(args)
  @args = {}
  @args[:dev_num] = (args.users_num || 100).to_i
end