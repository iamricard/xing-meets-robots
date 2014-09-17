require './test/test_helper'
require './lib/robots/xing_robot'

describe 'XINGRobot' do
  let(:robot) { XINGRobot.new }

  before :each do
    robot.work
  end

  it 'starts with green light on an red light off' do
    robot.jobs_ok.on?.must_equal true
    robot.jobs_ko.on?.must_equal false
  end
end
