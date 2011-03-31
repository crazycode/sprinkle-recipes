package :git do
  yum 'git-core'
  verify do
    has_executable 'git'
  end
end

package :svn do
  yum 'subversion'
  verify do
    has_executable 'svn'
  end
end

package :wget do
  yum 'wget'
  verify do
    has_executable 'wget'
  end
end

package :screen do
  yum 'screen'
  transfer "#{File.dirname(__FILE__)}/../config/.screenrc", '.screenrc'

  verify do
    has_executable 'screen'
    has_file '~/.screenrc'
  end
end

package :build_essentials do
  description 'Build tools'
  yum %w( make gcc gcc-c++ openssl-devel zlib-devel autoconf readline-devel curl-devel expat-devel gettext-devel ) do
    # Update the sources and upgrade the lists before we build essentials
    pre :install, 'yum update'
  end

  verify do
    has_executable 'g++'
  end
end

package :protoc do
  source "http://protobuf.googlecode.com/files/protobuf-2.3.0.tar.gz" do
    post :install, "ldconfig /usr/local/lib/"
  end
  verify do
    has_executable 'protoc'
    has_executable_with_version('protoc', '2.3.0', '--version')
  end
end
