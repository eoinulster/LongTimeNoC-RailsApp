class ClosecontactsEvent < ApplicationRecord
  belongs_to :event
  belongs_to :closecontact
  validate :event_and_closecontact_owner_are_same
  validates_uniqueness_of :event_id, :scope => :closecontact_id, :message => "A Closecontact can only be added once"

  def event_and_closecontact_owner_are_same
    if event.user != closecontact.user
      errors.add(:event, "Record creater must own closecontact")
    end
  end

end
