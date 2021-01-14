FROM nginx:latest
COPY . /usr/share/nginx/html/
RUN echo "This is a simple and easy env setup using docker"