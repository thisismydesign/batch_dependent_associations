class SafePerson < ActiveRecord::Base
  include BatchDependentAssociations

  has_many :bank_accounts, foreign_key: :person_id, class_name: "BankAccount", dependent: :destroy
  has_many :friends, foreign_key: :person_id, class_name: "Friend", dependent: :delete_all
end
