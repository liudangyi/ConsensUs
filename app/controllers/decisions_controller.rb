class DecisionsController < ApplicationController
  before_action :set_decision, except: [:index, :expand_short_url, :new, :create]
  before_action :require_admin, except: [:index, :expand_short_url, :new, :create, :show, :rate]
  before_action :authenticate_user!

  # GET /decisions
  # GET /decisions.json
  def index
    @memberships = current_user.memberships.includes(:decision)
  end

  # GET /s/:short_url
  def expand_short_url
    redirect_to Decision.find_by!(short_url: params[:short_url])
  end

  # GET /decisions/1/admin
  def admin
  end

  # GET /decisions/1
  # GET /decisions/1.json
  def show
    @scores = @membership.scores.group_by { |e| e.criterium_id }.map do |cid, v|
      [cid, v.map { |e| [e.alternative_id, e.value]  }.to_h]
    end.to_h
    render :rate
  end

  # POST /decisions/1/rate
  def rate
    scores = @membership.scores.group_by { |e| e.criterium_id.to_s }.map do |cid, v|
      [cid, v.map { |e| [e.alternative_id.to_s, e]  }.to_h]
    end.to_h
    params[:scores].each do |cid, v|
      v.map do |aid, value|
        if value.present? and value.to_f != scores[cid].try { |e| e[aid].try(:value) }
          value = value.to_f
          if score = scores[cid].try { |e| e[aid] }
            score.update(value: value)
          else
            @membership.scores.create(criterium_id: cid, alternative_id: aid, value: value)
          end
        end
      end
    end
    redirect_to :back
  end

  # GET /decisions/new
  def new
    @decision = Decision.new
  end

  # GET /decisions/1/edit
  def edit
  end

  # POST /decisions
  # POST /decisions.json
  def create
    @decision = Decision.new(decision_params)

    respond_to do |format|
      if @decision.save
        @decision.memberships.create!(user: current_user, role: :owner)
        format.html { redirect_to @decision, notice: 'Decision was successfully created.' }
        format.json { render :show, status: :created, location: @decision }
      else
        format.html { render :new }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decisions/1
  # PATCH/PUT /decisions/1.json
  def update
    respond_to do |format|
      if @decision.update(decision_params)
        format.html { redirect_to @decision, notice: 'Decision was successfully updated.' }
        format.json { render :show, status: :ok, location: @decision }
      else
        format.html { render :edit }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decisions/1
  # DELETE /decisions/1.json
  def destroy
    @decision.destroy
    respond_to do |format|
      format.html { redirect_to decisions_url, notice: 'Decision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decision
      @decision = Decision.find(params[:id])
      @membership = current_user.memberships.find_by!(decision: @decision)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def decision_params
      params.require(:decision).permit(:name, :description, :visibility)
    end
end
