#!/bin/bash

# Download and install code-server
wget https://raw.githubusercontent.com/coder/code-server/main/install.sh
chmod +x install.sh
./install.sh

# Install pyngrok
pip install pyngrok fire

# Download ngrok.py from this gist
wget https://raw.githubusercontent.com/ZeenathulNizreen/Code-server/main/ngrok.py

# Set up ngrok with auth token
python ngrok.py --ngrok_auth_token $2

# Tunnel given port to ngrok server with tmux session managemnet
tmux new -d -s mysession "/usr/bin/code-server --port $1 & ngrok http $1 & sleep 5s && cat /root/.config/code-server/config.yaml"

