class Excavator < ApplicationRecord
  belongs_to :ticket

  def full_address
    [self.street, self.city, self.state, self.zip].reject(&:blank?).join(", ")
  end
end
