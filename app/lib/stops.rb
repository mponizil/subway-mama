module Stops

  @csv = {}
  filepath = File.join(NSBundle.mainBundle.resourcePath, 'stops.csv')
  File.open(filepath, 'r') do |file|
    @csv = MotionCSV.parse(file.read)
  end

  module_function

  def all
    @csv
  end

end
