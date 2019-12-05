server {
  listen 80;
  listen 443 ssl http2;
  server_name dribbble.woaiso.com;
  ssl_certificate /data/ssl/woaiso.com/fullchain1.pem;
  ssl_certificate_key /data/ssl/woaiso.com/privkey1.pem;
  location / {
        root /data/www/dribbble;
        # 用于配合 browserHistory使用
        try_files $uri $uri/ /index.html;
  }
  location /api {
      rewrite ^/api/(.*)$ /$1 break;
      proxy_pass http://api:7001;
      proxy_set_header   X-Forwarded-Proto $scheme;
      proxy_set_header   Host              $http_host;
      proxy_set_header   X-Real-IP         $remote_addr;
  }
}