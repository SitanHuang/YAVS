require 'archive/zip'
require 'optparse'
require 'fileutils'

require_relative '../lib/init'
require_relative '../lib/status'
require_relative '../lib/log'

$YAVS_VERSION = 'v0.06A'

module YAVS
  def self.exist?
    File.directory? $YAVS_DOT_PWD
  end

  def self.lock
    FileUtils.touch '.yavs/temp/lock'
  end

  def self.lock?
    File.file? '.yavs/temp/lock'
  end

  def self.unlock
    File.delete '.yavs/temp/lock'
  end
end
