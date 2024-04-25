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

# Start ngrok in the background and wait for it to initialize
tmux new -d -s ngrokSession "ngrok http $1 -log=stdout > /root/ngrok.log 2>&1 && sleep 10"

# Wait for ngrok to fully initialize
sleep 10

# Start code-server in a separate tmux session
tmux new -d -s codeServerSession "/usr/bin/code-server --port $1 --auth password --bind-addr 127.0.0.1:$1 > /root/code-server.log 2>&1"

# Optional: Outputting the ngrok URL to the console
tmux new -d -s fetchNgrokUrl "sleep 15; curl --silent http://localhost:4040/api/tunnels | jq -r '.tunnels[] | select(.proto == \"https\") | .public_url' > /root/ngrok_url.txt"

echo "Setup completed. Ngrok URL can be found in /root/ngrok_url.txt"
