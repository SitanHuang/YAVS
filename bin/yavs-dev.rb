#!/usr/bin/env ruby

require 'pathname'
require 'fileutils'
require 'colorize'

def log m
  puts m
end

$YAVS_PATH = Pathname.new(__FILE__).realpath.parent.parent
$YAVS_LIB_PATH = "#{$YAVS_PATH}/lib"

$YAVS_PWD = Pathname.new(FileUtils.pwd).realpath
$YAVS_DOT_PWD = "#{$YAVS_PWD}/.yavs"

require_relative '../lib/yavs'
require_relative '../lib/init'

raise 'Repo locked! check .yavs/temp/lock' if YAVS.lock?

at_exit do
  begin
    YAVS.unlock
  rescue;;end
end

case ARGV.shift
  when '--version'
    puts $YAVS_VERSION
    exit
  when 'init'
    YAVS.init
    exit
  when 'push'
    version = ARGV.shift
    raise 'Put version for 2nd arg!' if version == nil
    YAVS.push version
    exit
  when 'version'
    puts File.read('.yavs/repo/versions')
    exit
  else
    raise 'Unknown command!'
    exit
end
