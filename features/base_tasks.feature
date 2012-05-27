Feature: Base tasks

  In order to manage install and uninstall of dotfiles
  As a developer with his dotfiles in git repository
  I want to be able to maintain them easily

  Scenario: List tasks inside their namespaces
    Given I run `thor list`
    Then the output should contain:
      """
      dotfiles
      --------
      """
    Then the output should contain:
      """
      git
      ---
      """
    Then the output should contain:
      """
      ruby
      ----
      """
    Then the output should contain:
      """
      vim
      ---
      """

  Scenario: Symlink all dotfiles

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
