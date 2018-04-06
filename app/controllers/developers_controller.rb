# frozen_string_literal: true

class DevelopersController < ApplicationController
  before_action :set_developer, only: %i[show edit update destroy]
  before_action :fetch_master_data, only: %i[index search]

  # GET /developers
  def index
    @developer_search_form = DeveloperSearchForm.new
    @developers = Developer.all
  end

  def search
    @developer_search_form = DeveloperSearchForm.new(developer_search_params)
    @developers = @developer_search_form.search

    render :index
  end

  # GET /developers/1
  def show; end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit; end

  # POST /developers
  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      redirect_to @developer, notice: 'Developer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /developers/1
  def update
    if @developer.update(developer_params)
      redirect_to @developer, notice: 'Developer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /developers/1
  def destroy
    @developer.destroy
    redirect_to developers_url, notice: 'Developer was successfully destroyed.'
  end

  private

  def fetch_master_data
    @programming_languages = ProgrammingLanguage.pluck(:name, :id)
    @languages = Language.pluck(:code, :id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_developer
    @developer = Developer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def developer_params
    params.require(:developer).permit(:email)
  end

  def developer_search_params
    params.require(:developer_search_form).permit(:programming_language_id, :language_id)
  end
end
