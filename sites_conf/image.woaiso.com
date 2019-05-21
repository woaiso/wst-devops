server {
  listen 80;
  server_name image.woaiso.com xia.woaiso.com;
  location / {
      proxy_pass http://image:5000;
      proxy_set_header   X-Forwarded-Proto $scheme;
      proxy_set_header   Host              $http_host;
      proxy_set_header   X-Real-IP         $remote_addr;
  }
}