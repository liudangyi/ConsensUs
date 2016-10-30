class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin

  # GET /memberships/new
  def new
    @membership = Membership.new(decision_id: params[:decision_id])
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  def create
    @membership = Membership.new(membership_params.merge(decision_id: params[:membership][:decision_id]))

    if @membership.save
      redirect_to admin_decision_path(@membership.decision_id), notice: 'Membership was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /memberships/1
  def update
    if @membership.update(membership_params)
      redirect_to admin_decision_path(@membership.decision_id), notice: 'Membership was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /memberships/1
  def destroy
    if @membership.user == current_user
      redirect_to :back, notice: 'You cannot delete yourself!'
    else
      @membership.destroy
      redirect_to admin_decision_path(@membership.decision_id), notice: 'Membership was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def membership_params
      params.fetch(:membership, {}).permit(:role, :invited_email)
    end
end
