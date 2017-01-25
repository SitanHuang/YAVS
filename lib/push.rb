require 'time'
require_relative 'diff'

module YAVS
  def self.push version, editor='vim'
    log "Pushing to `#{version}`"
    create_repo_files version


    File.write '.yavs/temp/msg', "Write here for changes in `#{version}`~"
    system editor, '.yavs/temp/msg'

    write_info version, File.read('.yavs/temp/msg')
    write_def version
    FileUtils.rm_rf ".yavs/repo/#{version}"
    write_versions version
  end

  def self.create_repo_files version
    FileUtils.mkdir ".yavs/repo/#{version}"
    Dir.glob './*' do |file|
      next if file == '.yavs'
      FileUtils.cp_r file, ".yavs/repo/#{version}"
    end
    Archive::Zip.archive ".yavs/repo/#{version}comp", ".yavs/repo/#{version}/."
  end

  def self.write_def version
    extract_previous_files
    content = YAVS::Diff.diff '.yavs/temp/extract', ".yavs/repo/#{version}"
    File.write ".yavs/repo/#{version}diff", content
    FileUtils.rm_rf '.yavs/temp/extract/.'
  end

  def self.extract_previous_files
    lver = File.read('.yavs/repo/versions').split("\n").last
    return -1 if lver == nil
    Archive::Zip.extract ".yavs/repo/#{lver}comp", '.yavs/temp/extract'
  end

  def self.write_versions version
    File.open '.yavs/repo/versions', 'a' do |file|
      file.puts version
    end
  end

  def self.write_info version, msg
    content = "#{Time.now}\n#{msg}"
    File.write ".yavs/repo/#{version}msg", content
  end
end
