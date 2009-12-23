Feature: ofx

  As a user
  I want to run outfox on my pdf bank statement
  So that I can get an ofx file that I can use with financial apps like Wesabe
  
  Background:
    Given I have a configured account
  
  @focus
  Scenario: account number
    When I run outfox with my statement
    Then the output ofx file should have the correct account number
