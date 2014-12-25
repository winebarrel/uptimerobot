module UptimeRobot
  module MonitorType
    HTTP = 1
    Keyword = 2
    Ping = 3
    Port = 4
  end

  module MonitorSubType
    HTTP = 1
    HTTPS = 2
    FTP = 3
    SMTP = 4
    POP3 = 5
    IMAP = 6
    Custom = 99
  end

  module MonitorKeywordType
    KeywordExists = 1
    KeywordNotExists = 2
  end
end
