# Encoding: utf-8

include_recipe 'nginx'

template File.join(node['nginx']['dir'], 'sites-available', 'kibana') do
  source 'nginx.erb'
  owner node['nginx']['user']
  mode '0644'
  variables(
    'root'                => File.join(node['kibana']['base_dir'], 'current'),
    'log_dir'             => node['nginx']['log_dir'],
    'listen_http'         => node['kibana']['nginx']['listen_http'],
    'listen_https'        => node['kibana']['nginx']['listen_https'],
    'client_max_body'     => node['kibana']['nginx']['client_max_body'],
    'server_name'         => node['kibana']['nginx']['server_name'],
    'ssl'                 => node['kibana']['nginx']['ssl'],
    'ssl_certificate'     => node['kibana']['nginx']['ssl_certificate'],
    'ssl_certificate_key' => node['kibana']['nginx']['ssl_certificate_key'],
    'ssl_protocols'       => node['kibana']['nginx']['ssl_protocols'],
    'ssl_ciphers'         => node['kibana']['nginx']['ssl_ciphers'],
    'ssl_session_cache'   => node['kibana']['nginx']['ssl_session_cache'],
    'ssl_session_timeout' => node['kibana']['nginx']['ssl_session_timeout'],
    'proxy'               => node['kibana']['nginx']['proxy'],
    'proxy_host'          => node['kibana']['nginx']['proxy_host'],
    'proxy_port'          => node['kibana']['nginx']['proxy_port'],
    'auth'                => node['kibana']['nginx']['auth'],
    'auth_file'           => node['kibana']['auth_file'],
  )
end

template "#{node['nginx']['dir']}/htpasswd" do
  variables(username: node['kibana']['nginx']['basic_auth_username'],
            password: node['kibana']['nginx']['basic_auth_password'])
  owner node['nginx']['user']
  group node['nginx']['group']
  mode 00644
end

nginx_site 'kibana' do
  enable true
end
