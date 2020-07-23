FROM nginx:latest

COPY inz-demo/inz-demo/ /usr/share/nginx/html

EXPOSE 80
