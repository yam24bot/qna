RSpec.describe Question, type: :model do
  it { is_expected.to have_many :answers }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
end
