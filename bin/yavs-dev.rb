#!/usr/bin/env ruby

require 'pathname'
require 'fileutils'
require 'colorize'

puts "\
========================
WARNING!
This version is pre-alpha and
should not seek stability.

I appreciate for bug reports
to 978494543.qq54@gmail.com. Thx.
========================

"

def log m
  puts m
end

$YAVS_PATH = Pathname.new(__FILE__).realpath.parent.parent
$YAVS_LIB_PATH = "#{$YAVS_PATH}/lib"

$YAVS_PWD = Pathname.new(FileUtils.pwd).realpath
$YAVS_DOT_PWD = "#{$YAVS_PWD}/.yavs"

require_relative '../lib/yavs'

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
  when 'status'
    YAVS::Status.status
    exit
  when 'extract'
    version = ARGV.shift
    version = YAVS.last_version if version == nil
    puts "Extracting `#{version}` to .yavs/temp/extract"
    YAVS.delete_extract
    YAVS.extract_version version
    exit
  when 'log'
    version = ARGV.shift
    if version != nil
      YAVS::Log.log_version version
    else
      YAVS::Log.log_all
    end
    exit
  when 'sync'
    host = ARGV.shift
    user = ARGV.shift
    passwd = ARGV.shift
    path = ARGV.shift
    YAVS::Sync.sync_ftp host, user, passwd, path
    exit
  else
    puts "\
    yavs (init | push | version | status | extract | log | --version | sync)
    yavs (status | log | push) [version]
    yavs sync host user passwd filepath
    "
    exit
end
