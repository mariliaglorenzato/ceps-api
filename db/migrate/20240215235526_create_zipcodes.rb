# frozen_string_literal: true

class CreateZipcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :zipcodes do |t|
      t.string :zipcode
      t.string :street
      t.string :neighbourhood
      t.string :city
      t.string :state
      t.string :country
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
