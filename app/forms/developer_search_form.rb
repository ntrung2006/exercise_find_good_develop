class DeveloperSearchForm
  include Virtus.model
  include ActiveModel::Model

  attribute :email, String
  attribute :pro_lang, Integer
  attribute :lang, Integer

  def search
    res = Developer.all.includes(:developer_languages, :developer_programming_languages)

    return res if (email.present? && pro_lang.present? && lang.present?)

    res = res.joins(:developer_languages).where("developer_languages.language_id = #{lang}") if lang.present?
    res = res.joins(:developer_programming_languages).where("developer_programming_languages.programming_language_id = #{pro_lang}") if pro_lang.present?

    res
  end
end
