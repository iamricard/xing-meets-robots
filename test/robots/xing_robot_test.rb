require './test/test_helper'
require './lib/robots/xing_robot'

describe 'XINGRobot' do
  let(:robot) { XINGRobot.new }

  before :each do
    robot.work
  end

  it 'starts with all lights on' do
    robot.jobs_ok.on?.must_equal true
    robot.jobs_ko.on?.must_equal true
  end

  describe 'jobs_broken' do
    before do
      robot.jobs_broken
    end

    it 'turns on red light and turns off green light' do
      robot.jobs_ok.on?.must_equal false
      robot.jobs_ko.on?.must_equal true
    end
  end

  describe 'jobs_works' do
    before do
      robot.jobs_works
    end

    it 'turns on green light and turns off red light' do
      robot.jobs_ok.on?.must_equal true
      robot.jobs_ko.on?.must_equal false
    end
  end
end
