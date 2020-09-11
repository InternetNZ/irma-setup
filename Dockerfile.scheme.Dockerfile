FROM nginx:1.19.1-alpine

COPY inz-demo/ /usr/share/nginx/html

EXPOSE 80
