FROM nginx:1.19.1-alpine

# context: ../irma-demo-ui/
COPY src/ /usr/share/nginx/html

EXPOSE 80
