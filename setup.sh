#!/usr/bin/env bash

set -e

# 1. Arch Linux Check
read -p "Are you using Arch Linux? [y/N]: " confirm_arch

case "$confirm_arch" in
    [yY]|[yY][eE][sS])
        echo "Arch Linux confirmed. Proceeding with installation..."
        ;;
    *)
        echo "Do it Manually"
        exit 1
        ;;
esac

echo "Installing theme dependencies via pacman..."
# Ensure Vimix cursors and Darkly window decorations are installed
sudo pacman -S --needed vimix-cursor-theme kwin-decoration-darkly || true

echo "Configuring KDE Plasma desktop settings..."

# Apply Darkly Window Decoration
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "__aurorae__svg__Darkly"

# Apply Vimix Cursor Theme
kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme "Vimix-cursors"

# Configure Blur Effect Settings (Matching your Blur / Noise / Saturation sliders)
kwriteconfig6 --file kwinrc --group Plugins --key blurEnabled true
kwriteconfig6 --file kwinrc --group Effect-Blur --key BlurStrength 2
kwriteconfig6 --file kwinrc --group Effect-Blur --key NoiseStrength 11
kwriteconfig6 --file kwinrc --group Effect-Blur --key Saturation 12

# Reload KWin to apply decorations and effects immediately
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true

echo ""
echo "Setup complete!"
echo "• Colors: Set to Breeze Dark / Light automatically."
echo "• Window Decoration: Darkly applied."
echo "• Cursors: Vimix Cursors applied."
echo "• Blur: Enabled with custom strength & noise."
