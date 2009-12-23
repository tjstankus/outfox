@tmpoutput
Feature: command line

  As a user
  I want to run the program from the command line
  So that I may create an ofx file from my pdf bank statement
  
  Scenario Outline: help option
    When I run outfox with options <options>
    Then I should see the help message
    
    Examples:
      | options |
      | -h      |
      | --help  |

  Scenario Outline: incorrect number of arguments
    When I run outfox with arguments <args>
    Then I should see instructions for viewing the help message
    
    Examples:
      | args    |
      |         |
      | foo     |
      | foo bar |
