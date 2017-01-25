task :default => [:bundle_install, :dev_run]

task :bundle_install do
  sh 'bundle'
end

task :dev_run do
  ruby 'bin/yavs-dev.rb'
end
