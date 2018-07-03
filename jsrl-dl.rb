require 'net/http'
require 'zip'

station = "ggs"
station = ARGV[0] if ARGV.length > 0

base_url = "https://jetsetradio.live/audioplayer/stations/#{station}/"
station_url = "#{base_url}~list.js"
target_dir = station + "/"

Dir.mkdir(target_dir)

contents = Net::HTTP.get URI(station_url)
contents = contents.gsub(/(.*?)"(.*?)";/, "\\2").split(/\r?\n/)

contents.each do |song|
  song = song + ".mp3"
  File.write(target_dir + song, Net::HTTP.get(URI(URI.escape(base_url + song))))
end
