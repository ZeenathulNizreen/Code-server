#!/bin/bash

# Download and install code-server
wget https://raw.githubusercontent.com/coder/code-server/main/install.sh
chmod +x install.sh
./install.sh

# Install pyngrok and fire
pip install pyngrok fire

# Download ngrok.py from the specified repository
wget https://raw.githubusercontent.com/ZeenathulNizreen/Code-server/main/ngrok.py

# Set up ngrok with auth token provided as the second argument
python ngrok.py --ngrok_auth_token "$2"

# Tunnel the given port to ngrok server and manage it within a tmux session
tmux new -d -s mysession "source /root/FedAgg/.venv/bin/activate && ngrok http $1 > /root/ngrok.log 2>&1 & sleep 10s && /usr/bin/code-server --port $1 > /root/code-server.log 2>&1 & sleep 5s && cat /root/.config/code-server/config.yaml"
