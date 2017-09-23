class StateTrackersController < ApplicationController
  def new
    @state_tracker = ObjectStateTracker.new
  end

  def create
    track_states || render(:new)
  end

  private

  def track_states
    @state_tracker = ObjectStateTracker.new(state_tracker_params)

    if @state_tracker.valid?
      render(:object_state)
    end
  end

  def state_tracker_params
    params.require(:object_state_tracker).permit(
      :tg_object_id, :tg_object_type, :timestamp
    )
  end
end
