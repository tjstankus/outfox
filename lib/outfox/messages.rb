module Outfox
  class Messages
    def self.starting_to_parse(filepath)
      "Parsing #{File.basename(filepath)}...\n"
    end
  end
end