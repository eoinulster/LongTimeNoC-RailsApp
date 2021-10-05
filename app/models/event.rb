class Event < ApplicationRecord
  belongs_to :user
  has_many :closecontacts_events, dependent: :destroy
  has_many :closecontacts, :through => :closecontacts_events
  validates :date, presence: true
  accepts_nested_attributes_for :closecontacts, reject_if: proc { |attributes| attributes['firstname'].blank? || attributes['secondname'].blank? }

  def nicetitle
      date.strftime("%a %b %d") + " - " + stringy
  end

  def stringy
      s = ""
      closecontacts.each do |cc|
          s.concat(cc.fullname)
          s.concat(", ")
      end
      return s
  end

  def self.to_csv
      attributes = %w{date duration location indoors closecontact_ids}

      CSV.generate(headers: true) do |csv|
          csv << attributes

          all.each do |event|
              array =  attributes.map{ |a| event.send(a) }
              csv << array
          end
      end
  end

  def time
      if date != nil
          date.strftime("%H:%M")
      end
  end

  def assign_ccs(ccs)
      ccs.each {|cc| cc.user = self.user}
      self.closecontacts.append(ccs) if !ccs.nil?
  end

  def newCcForEvent
      raise "problem" if user.nil?
      cc = Closecontact.new
      cc.user = self.user
      self.closecontacts << cc
      return cc
  end
end
