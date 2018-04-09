RSpec.describe BatchDependentAssociations do
  it "has a version number" do
    expect(BatchDependentAssociations::VERSION).not_to be nil
  end

  describe "" do
    context "" do
      it "" do
        unsafe_person = UnsafePerson.create!
        bank_account = BankAccount.create!(person_id: unsafe_person.id)
        p unsafe_person.inspect
        p bank_account.inspect
      end
    end
  end
end
