#!/usr/bin/env bash
# sets up both webservers for deployment
# Function to check if a symbolic link exists and points to a specific target
symlink_exists() {
    local symlink=$1
    local target=$2

    [[ -L $symlink && $(readlink -f $symlink) == $target ]]
}

# Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Define web_static directory paths
web_static_dir="/data/web_static"
releases_dir="$web_static_dir/releases"
shared_dir="$web_static_dir/shared"
current_dir="$web_static_dir/current"
test_release_dir="$releases_dir/test"

# Create necessary directories if they don't exist
sudo mkdir -p $releases_dir $shared_dir $test_release_dir

# Create a fake HTML file for testing
fake_html_file="$test_release_dir/index.html"
if [ ! -f $fake_html_file ]; then
    echo "Hello, this is a test page." | sudo tee $fake_html_file > /dev/null
fi

# Check if the symbolic link already exists and is correct
if ! symlink_exists $current_dir $test_release_dir; then
    # Remove the existing symbolic link if it's not correct or doesn't exist
    sudo rm -f $current_dir
    # Create the symbolic link
    sudo ln -s $test_release_dir $current_dir
fi

# Give ownership of the /data/ directory to the ubuntu user and group recursively
sudo chown -R ubuntu:ubuntu $web_static_dir

# Check if the Nginx configuration already contains the required alias
if ! grep -q "location /hbnb_static/ {" /etc/nginx/sites-enabled/default; then
    # Remove the existing alias block if it exists
    sudo sed -i '/location \/hbnb_static\//,/\}/d' /etc/nginx/sites-enabled/default
    # Add the alias block to the Nginx configuration
    echo "location /hbnb_static/ {" | sudo tee -a /etc/nginx/sites-enabled/default
    echo "    alias $current_dir/;" | sudo tee -a /etc/nginx/sites-enabled/default
    echo "}" | sudo tee -a /etc/nginx/sites-enabled/default
    # Restart Nginx to apply the configuration
    sudo service nginx restart
fi
