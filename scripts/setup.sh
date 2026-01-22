#!/bin/bash

echo "🎵 Starting Music Stack Setup..."

# 1. Update & Install System Dependencies
# We need xfce (desktop), tightvnc (server), novnc (web bridge), and libfuse2 (for AppImage)
echo "📦 Installing Desktop & Dependencies..."
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tightvncserver novnc python3-websockify libfuse2 wget

# 2. Download SpotiFLAC (The Downloader)
# We download it to the root project folder for easy access
echo "⬇️ Downloading SpotiFLAC v7.0.6..."
wget -q --show-progress -O SpotiFLAC.AppImage https://github.com/afkarxyz/SpotiFLAC/releases/download/v7.0.6/SpotiFLAC-Linux-x86_64.AppImage
chmod +x SpotiFLAC.AppImage

# 3. Configure VNC Startup
# This ensures the gray screen doesn't happen
echo "⚙️ Configuring VNC Startup..."
mkdir -p ~/.vnc
echo -e "#!/bin/bash\nxrdb \$HOME/.Xresources\nstartxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# 4. Install noVNC System Service
# Copies the service file from your repo to the system folder
echo "🔗 Installing Web Desktop Service..."
if [ -f "./scripts/novnc.service" ]; then
    sudo cp ./scripts/novnc.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable novnc
    echo "   -> Service installed and enabled."
else
    echo "   ⚠️ Warning: scripts/novnc.service not found. Skipping service install."
fi

echo "✅ Installation Complete!"
echo "------------------------------------------------"
echo "NEXT STEPS:"
echo "1. Run 'vncserver' to set your password and start the screen."
echo "2. Run 'sudo systemctl start novnc' to open the web bridge."
echo "3. Run 'docker compose up -d' to start the music server."
echo "------------------------------------------------"
