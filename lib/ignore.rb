require 'fileutils'

module YAVS
  module Ignore
    def self.list_ignored prefix='./'
      ignored = []
      File.read('.yavs/ignored').split("\n").each do |path|
        ignored += Dir.glob(prefix + path)
      end
      return ignored
    end
  end
end
