Feature: Vim tasks

  In order to specify tasks that handle vim installation
  As a developer
  I want to be able to issue them

  Scenario: list all install plugins
    Given a file named "vim/plugins.list" with:
      """
      git://github.com/tpope/vim-rails.git
      git://github.com/tpope/vim-cucumber.git
      """
   When I run `thor dotfiles:vim:list`
   Then the output should contain "git://github.com/tpope/vim-rails.git"
   And the output should contain "git://github.com/tpope/vim-cucumber.git"
