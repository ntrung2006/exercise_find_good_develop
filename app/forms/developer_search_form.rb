class DeveloperSearchForm
  include Virtus.model
  include ActiveModel::Model

  attribute :programming_language_id, Integer
  attribute :language_id, Integer

  def search

    developers = Developer.all

    developers = developers.joins(:developer_languages).where("developer_languages.language_id = #{language_id}") if language_id.present?
    developers = developers.joins(:developer_programming_languages).where("developer_programming_languages.programming_language_id = #{programming_language_id}") if programming_language_id.present?

    developers
  end
end
