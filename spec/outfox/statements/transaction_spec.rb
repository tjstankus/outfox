require File.join(File.dirname(__FILE__), *%w[.. .. spec_helper])

describe Outfox::Statements::Transaction do
  
  before(:all) do
    @statement = mock('statement')
  end
  
  describe "counter deposit" do
    before(:each) do
      @data = ["12/25", "4,582.50", "COUNTER", "DEPOSIT"]
      @txn = Outfox::Statements::Transaction.new(@statement, @data, :credit)
    end
    
    it "should have correct posted datetime" do
      @statement.should_receive(:year_for_month).and_return(2009)
      @txn.datetime_posted.should == DateTime.parse('2009-12-25')
    end

    it "should have correct transaction type" do
      @txn.transaction_type.should == 'DEP'
    end
    
    it "should have correct amount" do
      @txn.amount.should == '+4582.50'
    end
    
    it "should have correct name" do
      pending
      @txn.name.should == 'COUNTER DEPOSIT'
    end
    
    it "should not have date in info data" do
      @txn.info_data_includes_date?.should be_false
    end
    
    it "should have nil info data date index" do
      @txn.info_data_date_index.should be_nil
    end
    
    it "should have correct memo"
    
    it "should have correct transaction id"
    
  end
  
  describe "refund" do
    before(:each) do
      @data = ["11/09", "9.69", "REFUND", "BORDERS", "BKS&MU0100", "11/06", 
               "4828513085281", "CHAPEL", "HILL", "NC", "1024V714940"]
      @txn = Outfox::Statements::Transaction.new(@statement, @data, :credit)
    end
    
    it "should have correct posted datetime" do
      @statement.should_receive(:year_for_month).and_return(2009)
      @txn.datetime_posted.should == DateTime.parse('2009-11-09')
    end
    
    it "should have correct transaction type" do
      @txn.transaction_type.should == 'POS'
    end
    
    it "should have date in info data" do
      @txn.info_data_includes_date?.should be_true
    end
    
    it "should have correct info data date index" do
      @txn.info_data_date_index.should == 5
    end
    
    it "should have correct amount"
    
    it "should have correct transaction id"
    
    it "should have correct name"
    
    it "should have correct memo"
  end

end