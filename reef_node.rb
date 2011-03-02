

require File.join(File.dirname(__FILE__),'common.rb')

policy :reef_node, :roles => [:target_box] do
  requires :screen
  requires :java
  requires :postgresql
  requires :qpidd
  requires :qpidd_dev
  requires :qpid_commands
end

deploy
