module Outfox
  class OfxGenerator
    
    attr_accessor :currency
    
    def initialize(statement = nil)
      @statement = statement
    end
    
    def header
      [].tap do |arr|
        arr << '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
        arr << '<?OFX OFXHEADER="200" VERSION="203" SECURITY="NONE" OLDFILEUID="NONE" NEWFILEUID="NONE"?>'
      end.join("\n") << "\n"
    end
    
    def currency
      'USD'
    end
    
    def datetime_to_ofx(datetime)
      datetime.strftime('%Y%m%d%H%M%S')
    end
    
    def ofx
      ''.tap do |buf|
        buf << header
        xml = Builder::XmlMarkup.new(:target => buf, :indent => 2)
        xml.OFX {
          xml.BANKMSGSRSV1 { # bank message response
            xml.STMTTRNRS { # statement-transaction aggregate response
              xml.STMTRS { # statement response 
                xml.CURDEF currency
                xml.BANKACCTFROM {
                  xml.BANKID @statement.bank_routing_number
                  xml.ACCTID @statement.account_number
                  xml.ACCTTYPE @statement.account_type.upcase
                }
                xml.BANKTRANLIST {
                  xml.DTSTART datetime_to_ofx(@statement.start_date)
                  xml.DTEND datetime_to_ofx(@statement.end_date)
                }
              }
            }
          }
        }
      end
    end
    
  end
end