> Note: This setup is very personalised as per my liking on mac systems, this script will run on linux aswell, but do modify the Brewfile if you want to use it on linux (Remove all the mac store applications).
# Workflow on New Machine

1. Open the default Terminal.
2. Install Git if it's not there (it's usually pre-installed with Xcode Command Line Tools, which Homebrew will install).
3. Configure your SSH keys (if not already set up).
4. Clone this dotfiles repository.
5. Run the script.

---

## Configure SSH Keys

If you haven’t already configured SSH keys on this machine:

1. **Generate a new SSH key** (or skip this if you already have one):

    ```bash
    ssh-keygen -t ed25519 -C "your-email@example.com"
    ```

    Press `Enter` to accept the default file location. You can optionally set a passphrase.
<!-- Note: Use your email! -->
2. **Start the SSH agent**:

    ```bash
    eval "$(ssh-agent -s)"
    ```

3. **Add your SSH key to the agent**:

    ```bash
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    ```

    - If you're using an older version of macOS or OpenSSH, use `ssh-add ~/.ssh/id_ed25519` instead.

4. **Add the public key to your GitHub account**:

    ```bash
    pbcopy < ~/.ssh/id_ed25519.pub
    ```

    - Go to [https://github.com/settings/keys](https://github.com/settings/keys)
    - Click **New SSH key**
    - Paste the copied and give it a descriptive title (like "Machine Name - Month Year")

5. **Test your connection**:

    ```bash
    ssh -T git@github.com
    ```

    You should see a message like:
    > Hi your-username! You've successfully authenticated.

6. **Optional: Set Git to use SSH**
    
  - If you previously used HTTPS, you can switch to SSH:
  
    ```bash
    git remote set-url origin git@github.com:username/repo.git
    ```
  
  - Or when cloning a repo, use the SSH URL:
  
    ```bash
    git clone git@github.com:username/repo.git
    ```

---

## Clone this Dotfiles Repository

```bash
git clone git@github.com:Terra-01/dotfiles.git ~/dotfiles
```

---

## Run the Script

```bash
cd ~/dotfiles
./setup.sh
```

That's it. Sit back and watch. The script will:

1. Install Homebrew.
2. Install every single tool, GUI app, and App Store app from your `Brewfile`, including `stow`.
3. Use `stow` to create symlinks for your `.zshrc`, Ghostty config, and oh-my-posh config.

---

## Final Manual Steps

1. **Set Ghostty as Default Terminal**
   This is a macOS UI setting that cannot be scripted easily.

   1. Open Ghostty.

   2. Right-click any `.sh` or other script file in Finder → **Get Info**.

   3. Under **"Open with:"**, select `Ghostty.app`.

   4. Click the **"Change All..."** button.

   > This helps, but isn't a full default. As of today, macOS does not provide a simple command-line way to set the default terminal application for all protocols. You just have to start using it as your primary terminal.

2. **Restart Your Terminal**
   Close the default Terminal and open Ghostty. You should be greeted by a custom oh-my-posh prompt.

3. **Log In**
   You will need to manually log in to apps like:

   * NordVPN
   * Raycast
   * Raindrop.io

4. **Install Python/Node Versions**
   Your `.zshrc` is now in place, so `pyenv` and `nvm` are ready to use.
   Now you can install the specific language versions you need:

   ```bash
   pyenv install 3.12.0
   nvm install --lts
   ```
