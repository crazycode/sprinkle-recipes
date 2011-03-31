package :ruby do
  description 'Ruby Virtual Machine'
  version '1.9.2'
  patchlevel '180'
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{version}-p#{patchlevel}.tar.gz" # implicit :style => :gnu
  requires :ruby_dependencies
  verify do
    has_executable 'ruby'
  end
end

package :ruby_dependencies do
  description 'Ruby Virtual Machine Build Dependencies'
  yum %w( openssl-devel zlib-devel gcc gcc-c++ make autoconf readline-devel curl-devel expat-devel gettext-devel )
end

package :rake do
  gem 'rake'
  verify do
    has_executable 'rake'
  end
end

package :god do
  gem 'god'
  verify do
    has_executable 'god'
  end
end

package :bundler do
  gem 'bundler'
  verify do
    has_executable 'bundle'
  end
end

package :gem_capistrano do
  gem 'capistrano'
end

package :gem_ssh do
  gem 'net-ssh'
end

package :god_service do
  requires :god
  transfer "#{File.dirname(__FILE__)}/../config/god", 'god' do
    post :install, "sudo mv god /etc/init.d/god"
    post :install, "sudo chmod +x /etc/init.d/god"
    post :install, "sudo update-rc.d god defaults"
  end

  verify do
    has_file '/etc/init.d/god'
  end
end
