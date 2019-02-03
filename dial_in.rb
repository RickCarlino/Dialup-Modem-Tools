require "serialport"
require "pry"

port_name   = ENV.fetch("PORT", "/dev/ttyUSB0")

options     = {
  baud:         9600,
  data_bits:    8,
  stop_bits:    1,
  parity:       SerialPort::NONE,
  flow_control: SerialPort::SOFT, # IE5 is different than windows terminal
}

SerialPort.open(port_name, options) do |serial_port|
  options.map do |(k,v)| # Why!?!?!
    p = [k.to_s + "=",  v]
    puts "serial_port.#{p[0]} #{p[1]}"
    serial_port.send(*p)
  end

  puts "Ready?"
  gets.chomp

  sleep 1

  "OK\r\n".each_char do |char|
    puts char.inspect
    serial_port.print(char)
    sleep 0.014
  end

  sleep 3 # Wait for "ATDT000..." TODO: Pause via `serial_port.getc` or sth...

  "CONNECT\r\n".each_char do |char|
    puts char.inspect
    serial_port.print(char)
    sleep 0.014
  end

  puts "I NEED TO FINISH THIS!"
end
