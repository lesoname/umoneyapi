class User < ApplicationRecord
    has_many :debts
    validates :name, presence: true, length: {minumum: 1, maximum: 12}
end
