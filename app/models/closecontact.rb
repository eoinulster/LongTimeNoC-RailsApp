class Closecontact < ApplicationRecord
    validates :firstname, :secondname, presence: true
    belongs_to :user
    has_many :closecontacts_events, dependent: :destroy
    has_many :events, :through => :closecontacts_events

    def fullname
        firstname + " " + secondname
    end


end
