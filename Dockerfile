FROM nginx:alpine

# Eigene Nginx Konfiguration für Security Headers
COPY default.conf /etc/nginx/conf.d/default.conf

# Webseite & Assets
COPY style.css /usr/share/nginx/html/style.css
COPY index.html /usr/share/nginx/html/index.html
COPY insights.html /usr/share/nginx/html/insights.html
COPY linkedin-article.html /usr/share/nginx/html/linkedin-article.html
COPY strategiebericht-2025.html /usr/share/nginx/html/strategiebericht-2025.html
COPY architecture-report.html /usr/share/nginx/html/architecture-report.html
COPY cv.html /usr/share/nginx/html/cv.html
COPY battery-systems.html /usr/share/nginx/html/battery-systems.html
COPY home-automation.html /usr/share/nginx/html/home-automation.html
COPY sensor-fusion.html /usr/share/nginx/html/sensor-fusion.html
COPY Marcel.webp /usr/share/nginx/html/Marcel.webp
COPY fav.png /usr/share/nginx/html/fav.png

# SEO Files
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY sitemap.xml /usr/share/nginx/html/sitemap.xml