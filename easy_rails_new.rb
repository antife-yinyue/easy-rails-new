#!/usr/bin/env ruby
require "rubygems"
require "thor/group"

class EasyRailsNew < Thor::Group
  include Thor::Actions

  def set_up
    @app_name     = ask("Please input the name of the new app:")
    @ruby_version = ask("Please input the version of ruby (defaults: 1.9.3):")
    @gemset       = ask("Please input the name of gemset (if you want):")

    @ruby_version = "1.9.3" if @ruby_version == ""
  end

  def step1
    run "rails new #{@app_name} --skip-bundle --skip-gemfile --skip-test-unit"
  end

  def step2
    run "cd #{@app_name} && curl https://raw.github.com/eDoctor/eRails/master/templates/Gemfile > Gemfile"
  end

  def step3
    run "cd #{@app_name} && echo 'rvm use #{@ruby_version}#{"@" + @gemset unless @gemset == ""} --create' > .rvmrc"
  end

  def step4
    run "cd #{@app_name} && bundle install"
  end

  def step5
    run "cd #{@app_name} && rails g e_rails:install"
  end
end

EasyRailsNew.start
