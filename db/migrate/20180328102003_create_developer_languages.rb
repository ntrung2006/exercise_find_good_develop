class CreateDeveloperLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_languages do |t|
      t.references :developer, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end

    add_index :developer_languages, [:developer_id, :language_id], unique: true, name: 'index_developer_languages_on_dev_id_and_lang_id'
  end
end
