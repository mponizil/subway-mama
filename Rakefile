# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Subway Mama'
  app.icons = ['icon.png', 'icon@2x.png']
  app.prerendered_icon = true

  app.files << './app/config.rb'

  app.frameworks << 'EventKit'
  app.frameworks << 'AudioToolbox'

  app.pods do
    pod 'ProtocolBuffers'
  end

  app.vendor_project('vendor/NyctSubway', :static,
    :cflags => '-I../Pods/Headers/ProtocolBuffers/ProtocolBuffers')
end
