module YAVS
  module Status
    def self.status
      log "Files changed since `#{YAVS.last_version}`:"
      YAVS.delete_extract
      YAVS.extract_previous_files
      YAVS.create_repo_files '.yavstempextract'
      YAVS::Diff.diff '.yavs/temp/extract', '.yavs/repo/.yavstempextract'
      FileUtils.rm_rf ".yavs/repo/.yavstempextract"
      YAVS.delete_extract
    end
  end
end
