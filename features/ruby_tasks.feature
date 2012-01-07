Feature: Ruby tasks

  In order to manage ruby dotfiles through thor tasks
  As a developer
  I want to be able to issue them

  Background:
    Given a home directory with files:
      """
      .boson
      .gemrc
      .irbrc
      .railsrc
      """
    Given a directory named "ruby" with files:
      """
      gemrc.link
      irbrc.link
      """

  Scenario: Overwrite existing ruby dotfiles
    Given I run `thor dotfiles:ruby:install` interactively
    Then the stdout should contain "File already exists:"
    When I type "o"
    When I type "o"
