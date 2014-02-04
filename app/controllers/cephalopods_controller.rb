class CephalopodsController < ApplicationController
  before_action :set_cephalopod, only: [:show, :edit, :update, :destroy]

  # GET /cephalopods
  # GET /cephalopods.json
  def index
    @cephalopods = Cephalopod.all
  end

  # GET /cephalopods/1
  # GET /cephalopods/1.json
  def show
  end

  # GET /cephalopods/new
  def new
    @cephalopod = Cephalopod.new
  end

  # GET /cephalopods/1/edit
  def edit
  end

  # POST /cephalopods
  # POST /cephalopods.json
  def create
    @cephalopod = Cephalopod.new(cephalopod_params)

    respond_to do |format|
      if @cephalopod.save
        format.html { redirect_to @cephalopod, notice: 'Cephalopod was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cephalopod }
      else
        format.html { render action: 'new' }
        format.json { render json: @cephalopod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cephalopods/1
  # PATCH/PUT /cephalopods/1.json
  def update
    respond_to do |format|
      if @cephalopod.update(cephalopod_params)
        format.html { redirect_to @cephalopod, notice: 'Cephalopod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cephalopod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cephalopods/1
  # DELETE /cephalopods/1.json
  def destroy
    @cephalopod.destroy
    respond_to do |format|
      format.html { redirect_to cephalopods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cephalopod
      @cephalopod = Cephalopod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cephalopod_params
      params.require(:cephalopod).permit(:name, :tentacles)
    end
end
