import fire
from pyngrok import ngrok

def set_ngrok_auth_token(ngrok_auth_token):
  ngrok.set_auth_token(ngrok_auth_token)
  
if __name__ == "__main__":
  fire.Fire(set_ngrok_auth_token)