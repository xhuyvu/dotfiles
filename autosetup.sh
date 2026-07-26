

# Exit if any command fails
set -e

# List of packages to install
packages=(
    git
    curl
    neovim
    btop
    openjdk-17-jdk
    build-essential
    
)

echo "Updating package list..."
sudo apt update
sudo apt upgrade
echo "Installing packages..."

for package in "${packages[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "✓ $package is already installed."
    else
        echo "Installing $package..."
        sudo apt install -y "$package"
    fi
done
echo "adding java home"
echo -e 'export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"\nexport PATH="$JAVA_HOME/bin:$PATH"' >> ~/.bashrc



echo "All packages are installed!"