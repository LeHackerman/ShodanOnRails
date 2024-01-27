# frozen_string_literal: true

class FormDatum < ApplicationRecord
  validates :prompt,
            format: {
              with: Resolv::AddressRegex
            }
end
