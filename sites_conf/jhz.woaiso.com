server {
  listen 80;
  listen 443 ssl http2;
  server_name jhz.woaiso.com;
  ssl_certificate /data/ssl/woaiso.xyz/fullchain1.pem;
  ssl_certificate_key /data/ssl/woaiso.xyz/privkey1.pem;
  location / {
        root /data/www/jhz;
        # 用于配合 browserHistory使用
        try_files $uri $uri/ /index.html;
  }
location /api {
      proxy_pass http://transfer:8081;
      proxy_set_header   X-Forwarded-Proto $scheme;
      proxy_set_header   Host              $http_host;
      proxy_set_header   X-Real-IP         $remote_addr;
  }
}