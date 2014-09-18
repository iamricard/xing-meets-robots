require 'artoo'

class XINGRobot < Artoo::Robot

  connection :firmata, adaptor: :firmata, port: '/dev/ttyACM0'
  device :board, driver: :device_info
  api host: '127.0.0.1', port: '4321'
  device :jobs_ko, driver: :led, pin: 2
  device :jobs_ok, driver: :led, pin: 3

  work do
    puts "Firmware name: #{board.firmware_name}"
    puts "Firmata version: #{board.version}"
    jobs_ok.on
    jobs_ko.on
  end

  def jobs_broken
    jobs_ko.on
    jobs_ok.off
  end

  def jobs_works
    jobs_ko.off
    jobs_ok.on
  end

end
