require 'archive/zip'
require 'optparse'
require 'fileutils'

require_relative '../lib/init'
require_relative '../lib/status'
require_relative '../lib/log'
require_relative '../lib/sync_ftp'

$YAVS_VERSION = 'v0.20'

module YAVS
  def self.exist?
    File.directory? '.yavs'
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
