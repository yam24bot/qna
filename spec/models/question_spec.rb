require 'rails_helper'

RSpec.describe Question, type: :model do
  it { expect validate_presence_of :title }
  it { expect validate_presence_of :body }
end
