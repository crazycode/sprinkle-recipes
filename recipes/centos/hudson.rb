# sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
# sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

package :hudson_yum do
  requires :wget

  noop do
    pre :install, 'sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo'
    pre :install, 'sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
    post :install, 'sudo yum update'
  end

  verify do
     has_file '/etc/yum.repos.d/jenkins.repo'
  end
end

package :hudson_app do
  requires :java, :hudson_yum

  yum('jenkins')

  verify do
    has_file '/etc/init.d/jenkins'
  end

end

package :hudson do

  requires :hudson_app
  # only necessary to update the --prefix=/hudson setting, the replace_text function didn't work

  transfer '#{File.dirname(__FILE__)}/../config/hudson', 'hudson' do
    post :install, 'mv hudson /etc/default/hudson'
  end


  verify do
    file_contains '/etc/default/hudson', 'prefix'
  end

end
