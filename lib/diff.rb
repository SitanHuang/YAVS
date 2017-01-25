require 'colorize'

module YAVS
  module Diff
    def self.diff old, new
      content = ""
      add = add?(old, new).each do |file|
        content << "+ #{file}" << "\n"
        log "+ #{file}".green
      end
      delete?(old, new).each do |file|
        content << "- #{file}" << "\n"
        log "- #{file}".red
      end
      (modify?(old, new) - add).each do |file|
        content << "@ #{file}" << "\n"
        log "@ #{file}".yellow
      end
      return content
    end

    # delete -> compare old to new
    # add -> compare new to old
    # modify -> compare new to old
    def self.modify? old, new
      modify = []
      Dir.glob "#{new}/**/*" do |file|
        relative = file.sub "#{new}/", ''
        modify << relative if File.size?("#{old}/#{relative}") != File.size?(file)
      end
      return modify
    end

    def self.add? old, new
      add = []
      Dir.glob "#{new}/**/*" do |file|
        relative = file.sub "#{new}/", ''
        add << relative unless File.exist? "#{old}/#{relative}"
      end
      return add
    end

    def self.delete? old, new
      delete = []
      Dir.glob "#{old}/**/*" do |file|
        relative = file.sub "#{old}/", ''
        delete << relative unless File.exist? "#{new}/#{relative}"
      end
      return delete
    end
  end
end
