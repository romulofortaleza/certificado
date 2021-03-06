class TextsController < ApplicationController
  before_action :set_text, only: [:show, :edit, :update, :destroy]

  # GET /texts
  # GET /texts.json
  def index
    @nome_completo = Devise::LDAP::Adapter.get_ldap_param(current_user.username,"cn").first.force_encoding("utf-8")
    @texts = Text.all
  end

  # GET /texts/1
  # GET /texts/1.json
  def show

  end

  # GET /texts/new
  def new
    @text = Text.new
    @user = User.new
    #authorize @user
  end

  # GET /texts/1/edit
  def edit
    @user = User.new
    authorize @user
  end

  # POST /texts
  # POST /texts.json
  def create
    @text = Text.new(text_params)

    respond_to do |format|

      if @text.save
        format.html { redirect_to @text, notice: 'Criado com sucesso.' }
        format.json { render :show, status: :created, location: @text }
      else
        format.html { render :new }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1
  # PATCH/PUT /texts/1.json
  def update
    respond_to do |format|
      if @text.update(text_params)
        format.html { redirect_to @text, notice: 'Atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @text }
      else
        format.html { render :edit }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @user = User.new
    authorize @user
    @text.destroy
    respond_to do |format|
      format.html { redirect_to texts_url, notice: 'Apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_params
      params.require(:text).permit(:shortdescription, :description)
    end
end
