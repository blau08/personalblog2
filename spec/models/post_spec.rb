require 'rails_helper'

describe Post do
  it { should validate_presence_of :description }
  it { should belong_to :user }
end

describe Post do
  factory(:post) do
    description('example post')
    priority(1)
  end

  it 'converts the name to lowercase' do
    task = FactoryGirl.create(:post, :description => "Finagle the buffalo")
    task.name.should eq "finagle the buffalo"
  end
end
