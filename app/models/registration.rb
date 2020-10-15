# frozen_string_literal: true

class Registration < ApplicationRecord
  has_paper_trail
  belongs_to :user
end
