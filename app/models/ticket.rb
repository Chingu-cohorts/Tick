class Ticket < ApplicationRecord
  resourcify
  belongs_to :user
end
