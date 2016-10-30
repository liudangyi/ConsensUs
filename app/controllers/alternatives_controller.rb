class AlternativesController < ApplicationController
  before_action :set_alternative, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin

  # GET /alternatives/new
  def new
    @alternative = Alternative.new(decision_id: params[:decision_id])
  end

  # GET /alternatives/1/edit
  def edit
  end

  # POST /alternatives
  # POST /alternatives.json
  def create
    @alternative = Alternative.new(alternative_params.merge(decision_id: params[:alternative][:decision_id]))

    respond_to do |format|
      if @alternative.save
        format.html { redirect_to admin_decision_path(@alternative.decision_id), notice: 'Alternative was successfully created.' }
        format.json { render :show, status: :created, location: @alternative }
      else
        format.html { render :new }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alternatives/1
  # PATCH/PUT /alternatives/1.json
  def update
    respond_to do |format|
      if @alternative.update(alternative_params)
        format.html { redirect_to admin_decision_path(@alternative.decision_id), notice: 'Alternative was successfully updated.' }
        format.json { render :show, status: :ok, location: @alternative }
      else
        format.html { render :edit }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alternatives/1
  # DELETE /alternatives/1.json
  def destroy
    @alternative.destroy
    respond_to do |format|
      format.html { redirect_to admin_decision_path(@alternative.decision_id), notice: 'Alternative was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alternative
      @alternative = Alternative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alternative_params
      params.fetch(:alternative, {}).permit(:name, :description, :color)
    end
end
