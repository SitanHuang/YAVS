module YAVS
  module Status
    def self.status
      log "Files changed since `#{YAVS.last_version}`:"
      YAVS.delete_extract
      YAVS.extract_previous_files
      YAVS::Diff.diff '.yavs/temp/extract', '.'
      YAVS.delete_extract
    end
  end
end
