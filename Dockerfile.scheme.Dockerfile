FROM nginx:1.19.1

COPY inz-demo/ /usr/share/nginx/html

EXPOSE 80
