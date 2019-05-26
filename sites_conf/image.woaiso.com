server {
  listen 80;
  listen 443 ssl http2;
  server_name image.woaiso.com xia.woaiso.com;
  ssl_certificate /data/ssl/woaiso/fullchain1.pem;
  ssl_certificate_key /data/ssl/woaiso/privkey1.pem;
  location / {
      proxy_pass http://image:5000;
      proxy_set_header   X-Forwarded-Proto $scheme;
      proxy_set_header   Host              $http_host;
      proxy_set_header   X-Real-IP         $remote_addr;
  }
}