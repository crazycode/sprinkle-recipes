# sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
# sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

package :jenkins_yum do
  requires :wget

  noop do
    pre :install, 'sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo'
    pre :install, 'sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
    # post :install, 'sudo yum update'
  end

  verify do
     has_file '/etc/yum.repos.d/jenkins.repo'
  end
end

package :jenkins_app do
  requires :java, :jenkins_yum

  yum('jenkins')

  verify do
    has_file '/etc/init.d/jenkins'
  end

end

package :jenkins do

  requires :jenkins_app

  transfer "#{File.dirname(__FILE__)}/../config/jenkins", 'jenkins' do
    post :install, 'sudo mv jenkins /etc/default/jenkins'
  end


  verify do
    file_contains '/etc/default/hudson', '8099'  # Port
  end

end
