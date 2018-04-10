class SafePerson < ActiveRecord::Base
  include BatchDependentAssociations
  self.dependent_associations_batch_size = 5

  has_many :bank_accounts, foreign_key: :person_id, class_name: "BankAccount", dependent: :destroy
  has_many :friends, foreign_key: :person_id, class_name: "Friend", dependent: :delete_all
end
