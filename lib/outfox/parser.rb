module Outfox
  class Parser
    
    attr_reader :receiver
    
    def initialize(bank, account_type)
      klass = "Outfox::Statements::#{bank.camelize}#{account_type.camelize}Statement"
      @receiver = klass.constantize.new
    end
    
    def parse(io, pdf_file_path)
      PDF::Reader.file(pdf_file_path, self.receiver)
      io.write(Outfox::Messages.starting_to_parse(pdf_file_path))
    rescue SystemCallError => e
      io.write(e.message)
    rescue PDF::Reader::MalformedPDFError => e
      io.write(Outfox::ErrorMessages::UNPARSEABLE)
    end
    
  end
end