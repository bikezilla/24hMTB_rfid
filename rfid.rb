require 'revdev'
require 'pry'
require "optparse"

USAGE=<<__EOF
usage:
    ruby #{$0} event_device output_file

  read from event_device and output to file

example:
    #{$0} /dev/input/event5 /var/www/nginx/serve/file.txt
__EOF

LEFT_SHIFT = 42
ENTER = 28

KEYPRESS = :EV_KEY
KEYDOWN = 1

TIME_FORMAT = '%d.%m.%y %H:%M:%S'

PIDFILE = 'rfid.pid'
LOGFILE = 'rfid.log'

def line_format(buffer)
  "#{buffer};#{Time.now.strftime(TIME_FORMAT)}\n"
end

def key_value(input)
  input.hr_code.to_s.gsub('KEY_','')
end

def read_loop(evdev, file, log)
  log << "#{Time.now} : Listening on #{evdev.file.path}, writing to #{file.path} ... \n"
  buffer = ''

  loop do
    input = evdev.read_input_event

    if KEYPRESS == input.hr_type && KEYDOWN == input.value
      case input.code
      when LEFT_SHIFT
        buffer = ''
      when ENTER
        line = line_format(buffer)
        file << line
        log << "#{Time.now} : WRITE: #{line}\n"
      else
        buffer << key_value(input)
      end
    end
  end
end

def main
  File.open(PIDFILE, 'w') { |f| f << Process.pid }

  include Revdev
  STDOUT.sync = true

  if ARGV.length == 0
    puts USAGE
    exit false
  end

  evdev = EventDevice.new(ARGV[0])
  #evdev.grab

  file = File.open(ARGV[1],'at')
  file.sync = true

  log = File.open(LOGFILE, 'at')
  log.sync = true

  trap "INT" do
    log << "#{Time.now} : # recieved :INT - exiting!\n"
    #evdev.ungrab
    file.close
    log.close
    exit true
  end

  read_loop(evdev, file, log)
end

main
