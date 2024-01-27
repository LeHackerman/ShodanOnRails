# frozen_string_literal: true

class CreateFormData < ActiveRecord::Migration[7.1]
  def change
    create_table :form_data do |t|
      t.text :prompt

      t.timestamps
    end
  end
end
