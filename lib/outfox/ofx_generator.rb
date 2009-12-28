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
    
    def amount_for_ofx(transaction)
      amt = transaction.amount.to_s.insert(0, transaction.txn_type == :credit ? '+' : '-')
      missing_ones_cents_digit?(amt) ? amt + '0' : amt
    end
    
    def missing_ones_cents_digit?(amount_str)
      amount_str.slice(-2..-1).include?('.')
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
                  @statement.transactions.each do |txn|
                    xml.STMTTRN {
                      xml.TRNTYPE txn.transaction_type
                      xml.DTPOSTED datetime_to_ofx(txn.datetime_posted)
                    }
                  end
                }
              }
            }
          }
        }
      end
    end
    
  end
end