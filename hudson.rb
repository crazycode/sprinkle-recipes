
require File.join(File.dirname(__FILE__),'common.rb')

policy :reef_build_node, :roles => [:target_box] do
  requires :screen
  requires :git
  requires :svn
  requires :java
  requires :mvn3
  requires :ruby
  requires :gem_capistrano
  requires :jenkins
end

deploy
