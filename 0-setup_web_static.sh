#!/usr/bin/env bash
# sets up both webservers for deployment
# Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Create necessary directories if they don't exist
web_static_dir="/data/web_static"
test_release_dir="$web_static_dir/releases/test"

sudo mkdir -p "$web_static_dir/shared"
sudo mkdir -p "$test_release_dir"

# Create a fake HTML file
fake_html_file="$test_release_dir/index.html"
echo "Fake HTML content" | sudo tee "$fake_html_file" > /dev/null

# Create or recreate the symbolic link
current_link="$web_static_dir/current"
if [ -L "$current_link" ]; then
    sudo rm -f "$current_link"
fi
sudo ln -s "$test_release_dir" "$current_link"

# Give ownership of /data/ to ubuntu user and group (recursively)
sudo chown -R ubuntu:ubuntu "$web_static_dir"

# Update Nginx configuration
nginx_config_file="/etc/nginx/sites-available/default"
nginx_alias_config="location /hbnb_static/ {\n    alias $web_static_dir/current/;\n}\n"

if sudo grep -q "location /hbnb_static/" "$nginx_config_file"; then
    # Replace the existing alias block
    sudo sed -i "/location \/hbnb_static\//,/^}/c$nginx_alias_config" "$nginx_config_file"
else
    # Add the alias block if it doesn't exist
    sudo sed -i "/location /i$nginx_alias_config" "$nginx_config_file"
fi

# Restart Nginx
sudo service nginx restart
