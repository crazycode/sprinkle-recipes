package :nginx do
  description 'Nginx Http Server'
  version '0.8.54'
  source "http://nginx.org/download/nginx-#{version}.tar.gz" # implicit :style => :gnu
  requires :nginx_dependencies
  verify do
    has_executable 'nginx'
  end
end

package :nginx_dependencies do
  description 'Nginx Build Dependencies'
  yum %w( gcc libjpeg-devel libpng-devel libmcrypt libmcrypt-devel pcre pcre-devel )
end
