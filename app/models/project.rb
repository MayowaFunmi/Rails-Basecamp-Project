class Project < ApplicationRecord
    validates :name, :description, :user, presence: true
    belongs_to :user
end
