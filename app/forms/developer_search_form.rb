# frozen_string_literal: true

class DeveloperSearchForm
  include Virtus.model
  include ActiveModel::Model

  FORM_FIELDS = %w[programming_language_id language_id].freeze

  attribute :programming_language_id, Integer
  attribute :language_id, Integer

  def initialize(params)
    @developer_search_form = params[:developer_search_form] || {}
    FORM_FIELDS.each { |f| send("#{f}=", @developer_search_form[f]) }
  end

  def search
    developers = Developer.all

    developers = developers.joins(:developer_languages).where(developer_languages: { language_id: language_id }) if language_id.present?
    developers = developers.joins(:developer_programming_languages).where(developer_programming_languages: { programming_language_id: programming_language_id }) if programming_language_id.present?

    developers.includes(:languages, :programming_languages)
  end
end
