Given /^a home directory with files:$/ do |text|
  text.split('\n').each do |file_name|
    step "an empty file named \"#{home_dir}/#{file_name}\""
  end
end

Given /^a directory named "([^"]*)" with files:$/ do |directory, text|
  text.split('\n').each do |file_name|
    step "an empty file named \"#{directory}/#{file_name}\""
  end
end
