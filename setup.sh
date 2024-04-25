#!/bin/bash

# Download and install code-server
wget https://raw.githubusercontent.com/coder/code-server/main/install.sh
chmod +x install.sh
./install.sh

# Install pyngrok
pip install pyngrok fire

# Download ngrok.py from this gist
wget https://gist.githubusercontent.com/sachith-gunasekara/06ca96a0ff907415c3d94a09420c1e6c/raw/be236c014068a5cedcc3facda7b0f018c2682c16/ngrok.py

# Set up ngrok with auth token
python ngrok.py --ngrok_auth_token $2

# Tunnel given port to ngrok server
# ngrok http $1 & /usr/bin/code-server --port $1 & sleep 5s && cat /root/.config/code-server/config.yaml

tmux new -d -s mysession "source /root/FedAgg/.venv/bin/activate && /usr/bin/code-server --port $1 & ngrok http $1 & sleep 5s && cat /root/.config/code-server/config.yaml"
