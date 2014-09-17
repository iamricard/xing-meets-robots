require './lib/robots/xing_robot.rb'

robots = []
robots << XINGRobot.new(name: "arduino_bcn", commands: [:jobs_broken, :jobs_works])
XINGRobot.work!(robots)
