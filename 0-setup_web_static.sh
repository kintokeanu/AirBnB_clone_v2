#!/usr/bin/env bash
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

web_static_dir="/data/web_static"
test_release_dir="$web_static_dir/releases/test"

sudo mkdir -p "$web_static_dir/shared"
sudo mkdir -p "$test_release_dir"

fake_html_file="$test_release_dir/index.html"
echo "Fake HTML content" | sudo tee "$fake_html_file" > /dev/null

current_link="$web_static_dir/current"
if [ -L "$current_link" ]; then
    sudo rm -f "$current_link"
fi
sudo ln -s "$test_release_dir" "$current_link"

sudo chown -R ubuntu:ubuntu "$web_static_dir"

nginx_config_file="/etc/nginx/sites-available/default"
nginx_alias_config="location /hbnb_static/ {\n    alias $web_static_dir/curremt/;\n}\n"

if sudo grep -q "location /hbnb_static/" "$nginx_config_file"; then
    sudo sed -i "/location \/hbnb_static\//,/^}/c$nginx_alias_config" "$nginx_config_file"
else
    sudo sed -i "/location /i$nginx_alias_config" "$nginx_config_file"
fi

sudo service nginx restart