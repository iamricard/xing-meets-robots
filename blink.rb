require 'artoo'

connection :firmata, :adaptor => :firmata, :port => '/dev/cu.usbmodem1411' #linux
device :board, :driver => :device_info
device :led, :driver => :led, :pin => 13

work do
  puts "Firmware name: #{board.firmware_name}"
  puts "Firmata version: #{board.version}"

  loop do
    led.toggle if gets.chomp
  end
end
