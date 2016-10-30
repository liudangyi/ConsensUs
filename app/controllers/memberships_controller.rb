class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships/new
  def new
    @membership = Membership.new(decision_id: params[:decision_id])
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  def create
    decision_id = params[:membership][:decision_id]
    raise AccessDenied unless current_user.memberships.find_by!(decision_id: decision_id).owner?
    @membership = Membership.new(membership_params.merge(decision_id: decision_id))

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
    @membership.destroy
    redirect_to admin_decision_path(@membership.decision_id), notice: 'Membership was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
      raise AccessDenied unless current_user.memberships.find_by!(decision_id: @membership.decision_id).owner?
    end

    # Only allow a trusted parameter "white list" through.
    def membership_params
      params.fetch(:membership, {}).permit(:role, :invited_email)
    end
end
