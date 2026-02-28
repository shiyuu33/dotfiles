# dotfiles

## Setup

### 1. Install packages

```sh
brew bundle
```

### 2. Create symlinks

```sh
./link.sh
```

Existing files are backed up with a `.backup` suffix.

### 3. Set personal information

Create `~/.gitconfig.local` with your git user info:

```ini
[user]
    name = Your Name
    email = your@email.com
```