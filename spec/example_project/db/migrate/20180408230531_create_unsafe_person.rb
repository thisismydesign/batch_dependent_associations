class CreateUnsafePerson < ActiveRecord::Migration[5.1]
  def change
    create_table :unsafe_people do |t|
    end
  end
end
