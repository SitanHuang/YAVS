require_relative 'push'

module YAVS
  def self.init opts={}
    log 'Creating new repo...'
    opts = {

    } if opts.empty?
    raise 'Repo already exists!' if exist?

    FileUtils.mkdir_p '.yavs/temp/extract'
    lock
    FileUtils.mkdir_p '.yavs/repo'
    File.write '.yavs/repo/versions', ''

    push 'initial'
  end
end
