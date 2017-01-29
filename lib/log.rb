module YAVS
  module Log
    def self.log_all
      File.read('.yavs/repo/versions').split("\n").each do |version|
        log_version version
        log ''
      end
    end

    def self.log_version version
      msg_raw = File.read(".yavs/repo/#{version}msg").split "\n"
      date = msg_raw.shift
      msg = msg_raw.join "\n\t"
      diff = File.read ".yavs/repo/#{version}diff"

      log "====== #{version} ======".bold
      log "Date: #{date}".bold
      log "Msg: \t#{msg}\n"
      YAVS::Diff.colorize diff
    end
  end
end
