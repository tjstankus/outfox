Given /^I have a "([^\"]*)" file with account number: "([^\"]*)"$/ do |filepath, acct_num|
  @account_number = acct_num
  lambda { File.open(File.join(FIXTURE_PATH, filepath)) }.should_not raise_error
end


Then /^the output ofx file should have the account number$/ do
  ofx = File.read(OFX_OUTPUT_FILE)
  ofx.should include(@account_number)
end
