describe Answer do
  it { is_expected.to belong_to :question }
  it { is_expected.to validate_presence_of :body }
end
