require 'fileutils'

task :default => [:install]

task :bundle_install do
  sh 'gem install rake diff-lcs colorize io-like archive-zip rspec'
end

task :dev_run do
  ruby 'bin/yavs-dev.rb'
end

task :install => [:bundle_install] do
  directory '/usr/local/yavs'
  FileUtils.cp_r 'bin', '/usr/local/yavs'
  FileUtils.cp_r 'lib', '/usr/local/yavs'
  sh "ln -s #{File.absolute_path 'bin/yavs-dev.rb'} '/usr/local/bin/yavs'"
end
