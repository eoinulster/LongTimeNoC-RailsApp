class EventsController < ApplicationController
  before_action :require_user!

  def index
      @events = current_user.events.sort_by {|e| e.date}

      respond_to do |format|
          format.html
          format.csv { send_data current_user.events.to_csv, filename: "close-contacts.csv" }
      end
    end

  def show
    @event = Event.find(params[:id])
        if @event.user == current_user
            render :show
        else
            redirect_to user_events_url(current_user)
        end
  end

  def new
    @event = Event.new
    @event.user = current_user
    @all_contacts = current_user.closecontacts

    @one = @event.newCcForEvent

    render :new
  end

  def create
      @event = Event.new(event_params)
      @event.closecontacts.each {|c| c.update_attributes(user: current_user)}
      @event.date = get_date_and_time
      @event.user = current_user
      params[:event][:closecontact_ids].each {|id| @event.closecontacts.append(Closecontact.find(id)) if id.length > 0 }

      if @event.save
          redirect_to user_events_url(current_user)
      else
          flash.now[:errors] = @event.errors.full_messages
          render :new
      end
  end

  def edit
      @event = Event.find(params[:id])
      if @event.user == current_user
          @all_contacts = current_user.closecontacts
          render :edit
      else
          redirect_to user_events_url(current_user)
      end
  end

  def update
    @event = Event.find(params[:id])
    ep = event_params
    ep[:date] = get_date_and_time
    @event.assign_attributes(ep)
    @event.closecontacts = []
    @event.assign_ccs(new_ccs)
    @event.assign_ccs(chosen_ccs)

    if (@event.user == current_user) && @event.save
      redirect_to user_events_url(current_user)
    else
      flash.now[:errors] = @event.errors.full_messages
      render :edit
    end
  end

  def chosen_ccs
      chosen_ccs = []
      # params[:event][:closecontact_ids].each {|id| chosen_ccs.append(Closecontact.find(id)) if id.length > 0 }
      @e = Event.new
      @e.closecontact_ids = params[:event][:closecontact_ids]
      # return chosen_ccs.to_set.to_a
      return @e.closecontacts.to_set.to_a
  end

  def new_ccs
      @e = Event.new(event_params)
      return @e.closecontacts
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
        @event.destroy
        redirect_to user_events_url(current_user)
    else
        redirect_to user_events_url(current_user)
    end

  end

  def get_date_and_time
      time = params[:event][:time]
      date = params[:event][:date]
      if (date == nil || time == nil)
          return Time.now
      end
      combine = date + "T" + time
      dt = combine.to_time
      return dt
  end

  private

  def event_params
    params.require(:event).permit(:location, :duration, :closecontact_ids, :indoors, closecontacts_attributes: [ :id, :firstname, :secondname ])
  end
end
