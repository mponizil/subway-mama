csv = nil
filepath = File.join(NSBundle.mainBundle.resourcePath, 'stops.csv')
File.open(filepath, 'r') do |file|
  csv = MotionCSV.parse(file.read)
end
