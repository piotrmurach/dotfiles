Feature: Base tasks

  In order to manage install and uninstall of dotfiles through thor tasks
  As a developer
  I want to be able to issue them

  Scenario: Skip all installed dotfiles
    Given a file named "git/git-completion.bash.link" with:
      """
      dummy content
      """
    Given a file named "git/gitignore.link" with:
      """
      dummy content
      """
    When I run `thor dotfiles:base:install` interactively
    And I type "S"
    Then the output should contain "Symlinking git/gitignore.link"
    And the output should not contain "Symlinkg git/git-completion.bash.link"
