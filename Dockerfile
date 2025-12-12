FROM nginx:alpine

# Copy the custom Nginx configuration
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy all website source files from the 'src' directory
# to the Nginx web root. The content of 'src' will become the root.
COPY src/ /usr/share/nginx/html/

# Optional: Set correct permissions for the web files
RUN chown -R nginx:nginx /usr/share/nginx/html && chmod -R 755 /usr/share/nginx/html