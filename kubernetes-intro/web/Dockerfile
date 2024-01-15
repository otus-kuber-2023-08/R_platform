FROM nginx
RUN mkdir /app/
RUN usermod -u 1001 nginx && groupmod -g 1001 nginx
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8000
CMD ["nginx", "-g", "daemon off;"]
