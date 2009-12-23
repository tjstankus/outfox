Given /^I have a configured account$/ do
  acct_info_path = File.join(CONFIG_PATH, 'account_info.yml')
  File.exists?(acct_info_path).should be_true
  @config = YAML.load_file(acct_info_path)
  @config['account_type'].should_not be_nil
  @config['account_number'].should_not be_nil
end

When /^I run outfox with my statement$/ do
  pending
  # outfox wachovia checking statement.pdf
end

Then /^the output ofx file should have the correct account number$/ do
  pending # express the regexp above with the code you wish you had
end