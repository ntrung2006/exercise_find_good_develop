class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update, :destroy]
  before_action :get_master_data, only: [:index, :search]

  # GET /developers
  def index
    @developer_search_form = DeveloperSearchForm.new
    @developers = Developer.all.includes(:developer_languages, :developer_programming_languages)
  end

  def search
    @developer_search_form = DeveloperSearchForm.new(developer_search_params)
    @developers = @developer_search_form.search

    render :index
  end

  # GET /developers/1
  def show
  end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit
  end

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

  def get_master_data
    @pro_lang = ProgrammingLanguage.all.pluck(:name, :id)
    @lang = Language.all.pluck(:code, :id)
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
    params.require(:developer_search_form).permit(:email, :pro_lang, :lang)
  end
end
