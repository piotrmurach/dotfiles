Feature: Ruby tasks

  In order to manage ruby dotfiles through thor tasks
  As a developer
  I want to be able to issue them

  Background:
    Given an empty file named "ruby/gemrc.link"
    And an empty file named "ruby/irbrc.link"

  Scenario: Skip all installed ruby dotfiles
    Given I run `thor dotfiles:ruby:install` interactively
    And I type "S"
    Then the output should contain ""
