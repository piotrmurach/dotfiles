alias bi='bundle install'
alias bu='bundle update'
alias migrate='rake db:migrate && rake db:test:prepare'
alias cuke='cucumber'

# RVM
alias rjav="rvm use \$(rvm list strings | grep -i jruby | tail -1)"
alias rmac="rvm use \$(rvm list strings | grep -i macruby | tail -1)"
alias r187="rvm use \$(rvm list strings | grep -i 1.8.7 | tail -1)"
alias r191="rvm use \$(rvm list strings | grep -i 1.9.1 | tail -1)"
alias r192="rvm use \$(rvm list strings | grep -i 1.9.2 | tail -1)"
alias r193="rvm use \$(rvm list strings | grep -i 1.9.3 | tail -1)"
