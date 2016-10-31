class CriteriaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_criterium, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  # GET /criteria/new
  def new
    @criterium = Criterium.new(decision_id: params[:decision_id])
  end

  # GET /criteria/1/edit
  def edit
  end

  # POST /criteria
  # POST /criteria.json
  def create
    @criterium = Criterium.new(criterium_params.merge(decision_id: params[:criterium][:decision_id]))

    respond_to do |format|
      if @criterium.save
        format.html { redirect_to admin_decision_path(@criterium.decision_id), notice: 'Criterium was successfully created.' }
        format.json { render :show, status: :created, location: @criterium }
      else
        format.html { render :new }
        format.json { render json: @criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria/1
  # PATCH/PUT /criteria/1.json
  def update
    respond_to do |format|
      if @criterium.update(criterium_params)
        format.html { redirect_to admin_decision_path(@criterium.decision_id), notice: 'Criterium was successfully updated.' }
        format.json { render :show, status: :ok, location: @criterium }
      else
        format.html { render :edit }
        format.json { render json: @criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria/1
  # DELETE /criteria/1.json
  def destroy
    @criterium.destroy
    respond_to do |format|
      format.html { redirect_to admin_decision_path(@criterium.decision_id), notice: 'Criterium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criterium
      @criterium = Criterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criterium_params
      params.fetch(:criterium, {}).permit(:name, :description)
    end
end
