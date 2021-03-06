# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the RateMyPup home page$/ then '/'
    when /^the "Create New Pup Test" page$/ then new_pup_path(:potato=>{:poops=>"Alex McGourty"}, :breeder=>{:name=>"",:city=>"",:state=>""})
    when /^the "Create New Pup" page$/ then new_pup_path
    when /^the "Pups" page$/ then '/pups'
    when /^the Login page$/ then '/users/sign_in'
    when /^the Signup page$/ then '/users/sign_up'
    when /^the "Add breeder" page$/ then '/breeders/new'
    when /^the Breed page$/ then '/breed'
    # Add more mappings here
    when /^the "Dog Name" page$/ then dog_name_path
    when /^the "Dog How Long Test" page$/ then dog_how_long_path(:pup=>{:pup_name=>"Doggie"})
    when /^the "Dog How Long" page$/ then dog_how_long_path
    when /^the "Dog Breed Test" page$/ then dog_breed_path(:pup=>{:years=>"1",:months=>"1"})
    when /^the "Dog Breed" page$/ then dog_breed_path
    when /^the "Dog Breeder Test" page$/ then dog_breeder_path(:button_clicked => "Next", :breed => {:name => "Affenpinscher"})
    when /^the "Dog Breeder" page$/ then dog_breeder_path
    when /^the Welcome page$/ then "/welcome"

      # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
