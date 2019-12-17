server {
  listen 80;
  listen 443 ssl http2;
  server_name kibana.woaiso.com;
  include /etc/nginx/sites-enabled/ssl_certificate_woaiso;
  location / {
      proxy_pass http://kibana:5601;
      proxy_set_header   X-Forwarded-Proto $scheme;
      proxy_set_header   Host              $http_host;
      proxy_set_header   X-Real-IP         $remote_addr;
  }
}