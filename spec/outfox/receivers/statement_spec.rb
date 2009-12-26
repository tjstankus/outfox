require File.join(File.dirname(__FILE__), *%w[.. .. spec_helper])

describe Outfox::Receivers::Statement do
  
  before(:each) do
    @methods = [ :bank_routing_number, :account_number, :account_type ]
    @statement = Outfox::Receivers::Statement.new
  end
  
  it "should respond to #bank_routing_number" do
    @statement.should respond_to(:bank_routing_number)
  end
  
  it "should raise error for #bank_routing_number" do
    lambda {@statement.bank_routing_number}.should raise_error
  end
  
  it "should respond to #account_number" do
    @statement.should respond_to(:account_number)
  end
  
  it "should raise error for #account_number" do
    lambda {@statement.account_number}.should raise_error
  end
  
  it "should respond to #account_type" do
    @statement.should respond_to(:account_type)
  end
  
  it "should raise error for #account_type" do
    lambda {@statement.account_type}.should raise_error
  end
  
end