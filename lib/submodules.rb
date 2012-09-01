module Submodules

  LINES_TO_REMOVE = 4

  # Modules handling

  # Extract name for git module for supplied url
  #
  # @param [String] the repository url
  # @return [string] the repository name
  #
  def extract_module_name(url)
    url.split('/').last.gsub('.git', '')
  end

  # Installs git module
  #
  # @param [String] url
  # @param [String] path to directory
  #
  def install_submodule(url, path)
    name = extract_module_name url
    say "Installing #{name} from #{url} as git submodule inside #{root}/#{path}", :green
    run "git submodule add #{url} #{path}/#{name}"
    run 'git submodule init'
    run 'git submodule update'
    ignore_submodule name
  end

  # Stop tracking module changes
  #
  # @param [String] module name
  #
  def ignore_submodule(name)
    insert_into_file "#{root}/.gitmodules", "\n  ignore = untracked",
      :after => /.*url.*#{name}.*$/,
      :force => true
  end

  # Remove git submodule entry inside .gitmodule file
  #
  # @param [String] module name
  #
  def delete_git_module(name)
    gitmodules = File.readlines("#{root}/.gitmodules")
    index = nil
    gitmodules.each_with_index do |line, indx|
      index = indx; break if line.index(name)
    end
    if index
      gitmodules.slice!(index, LINES_TO_REMOVE)
    end
    File.open("#{root}/.gitmodules", 'w+') do |file|
      gitmodules.each { |line| file.puts(line) }
    end
  end

  # Remove git submodule entry inside .git directory
  #
  # @param [String] module name
  # @param [String] module path
  #
  def remove_git_module(name, path)
    remove_dir "#{root}/.git/modules/#{path}"
  end

  # Completely remove git submodule entry.
  #
  # @param [String] repository url
  # @param [String] module path
  #
  def uninstall_submodule(url, path)
    name = extract_module_name url
    say "Uninstalling git module #{name} from #{root}/#{path}", :red
    delete_git_module name
    run "git rm --cached #{path}/#{name}"
    FileUtils.rm_rf "#{path}/#{name}"
    remove_git_module name, path
  end

  # Brings all the submodules up to date.
  #
  def update_submodules
    say "Updating git submodules", :green
    [
      'git submodule init',
      'git submodule update',
      'git submodule foreach git reset --hard',
      'git submodule foreach git checkout master',
      'git submodule foreach git pull -q origin master'
    ].each do |cmd|
      run "#{cmd}"
    end
    say "Git submodules successfully updated", :green
  end

  # Shows available submodules
  #
  def status
    run "git submodule status"
  end

end # Submodules
