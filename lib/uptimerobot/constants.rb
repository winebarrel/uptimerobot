module UptimeRobot
  module Monitor
    module Type
      HTTP = 1
      Keyword = 2
      Ping = 3
      Port = 4
    end

    module SubType
      HTTP = 1
      HTTPS = 2
      FTP = 3
      SMTP = 4
      POP3 = 5
      IMAP = 6
      Custom = 99
    end

    module KeywordType
      Exists = 1
      NotExists = 2
    end

    module Status
      Paused = 0
      NotCheckedYet = 1
      Up = 2
      SeemsDown = 8
      Down = 9
    end
  end

  module Log
    module Type
      Down = 1
      Up = 2
      Paused = 99
      Started = 98
    end
  end

  module AlertContact
    module Type
      SMS = 1
      Email = 2
      TwitterDM = 3
      Boxcar = 4
      WebHook = 5
      Pushbullet = 6
      Zapier = 7
      Pushover = 9
      HipChat = 10
      Slack = 11
    end

    module Status
      NotSctivated = 0
      Paused = 1
      Active = 2
    end
  end
end
