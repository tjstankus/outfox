require File.join(File.dirname(__FILE__), *%w[.. spec_helper])

describe Outfox::OfxGenerator do
  
  before(:all) do
    @statement = mock('statement', { 
      :bank_routing_number => '053000219', 
      :account_number => '1010101234567',
      :account_type => 'checking',
      :start_date => DateTime.parse('2009-09-29'),
      :end_date => DateTime.parse('2009-10-28'),
      :transactions => [] })
    @generator = Outfox::OfxGenerator.new(@statement)
    @ofx = @generator.ofx
  end
  
  it "should have a header" do
    @generator.header.should_not be_nil
  end
  
  it "should include bank routing number" do
    @ofx.should include('<BANKID>053000219</BANKID>')
  end
  
  it "should include account number" do
    @ofx.should include('<ACCTID>1010101234567</ACCTID>')
  end
  
  it "should include account type" do
    @ofx.should include('<ACCTTYPE>CHECKING</ACCTTYPE>')
  end
  
  it "should have transactions list" do
    @ofx.should include('<BANKTRANLIST>')
  end
  
  it "should have a start date" do
    @ofx.should include('<DTSTART>20090929000000</DTSTART>')
  end
  
  it "should have an end date" do
    @ofx.should include('<DTEND>20091028000000</DTEND>')
  end
  
end