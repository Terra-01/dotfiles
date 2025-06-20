#!/bin/zsh

# Exit immediately if a command exits with a non-zero status.
set -e

# Change the working directory to the location of the script itself.
cd "$(dirname "$0")"

echo "🚀 Starting automated Mac setup..."
echo "Running from: $(pwd)" # This will now always correctly show the dotfiles dir

# --- Step 1: Install Homebrew ---
if test ! $(which brew); then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to your PATH for the current session and for future sessions
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "🍺 Homebrew is already installed."
fi

# --- Step 2: Restore all applications from Brewfile ---
echo "📦 Restoring applications from Brewfile. This might take a while..."
brew bundle install --file ./Brewfile

# --- Step 3: Link dotfiles using Stow ---
echo "🔗 Linking configuration files using Stow..."
stow zsh
stow ghostty
stow ohmyposh

echo ""
echo "🎉 Setup complete!"
echo "Some applications may need to be restarted (like your terminal)."
echo "You may also need to manually log into services like NordVPN and Raycast."
