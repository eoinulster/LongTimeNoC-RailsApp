class ClosecontactsController < ApplicationController
  before_action :set_closecontact, only: [:show, :edit, :update, :destroy]
  before_action :require_user!
  

  # GET /closecontacts
  # GET /closecontacts.json
  def index
    @closecontacts = current_user.closecontacts
  end

  # GET /closecontacts/1
  # GET /closecontacts/1.json
  def show
      @closecontact = Closecontact.find(params[:id])
          if @closecontact.user == current_user
              render :show
          else
              redirect_to user_closecontacts_url(current_user)
          end
  end

  # GET /closecontacts/new
  def new
    @closecontact = Closecontact.new
  end

  # GET /closecontacts/1/edit
  def edit
      @closecontact = Closecontact.find(params[:id])
      if @closecontact.user == current_user
          render :edit
      else
          redirect_to user_closecontacts_url(current_user)
      end
  end

  # POST /closecontacts
  def create
    @closecontact = Closecontact.new(closecontact_params)
    @closecontact.user = current_user

    if @closecontact.save
        redirect_to user_closecontacts_url(current_user), notice: 'Contact was successfully added.'
    else
        flash.now[:errors] = @closecontact.errors.full_messages
        render :new
    end
  end

  # PATCH/PUT /closecontacts/1
  def update
      @closecontact = Closecontact.find(params[:id])
      if (@closecontact.user == current_user) && @closecontact.update(closecontact_params)
        redirect_to user_closecontacts_url(current_user)
      else
        flash.now[:errors] = @closecontact.errors.full_messages
        render :edit
      end
  end

  # DELETE /closecontacts/1
  # DELETE /closecontacts/1.json
  def destroy
      @closecontact = Closecontact.find(params[:id])
      if @closecontact.user == current_user
          @closecontact.destroy
          redirect_to user_closecontacts_url(current_user)
      else
          redirect_to user_closecontacts_url(current_user)
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_closecontact
      @closecontact = Closecontact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def closecontact_params
      params.require(:closecontact).permit(:firstname, :secondname, :telephone, :email, :regular)
    end

end
