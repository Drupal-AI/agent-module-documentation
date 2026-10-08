# Configuration

Because llama.cpp runs on your own infrastructure, configuring this provider is
mostly about telling it **where** the server is. There is usually no API key to
store for a local server.

## 1. Run a llama.cpp server

Start llama.cpp's HTTP server with its OpenAI-compatible API enabled, loaded with
the model you want to serve. Note the **base URL** it listens on — for example
`http://127.0.0.1:8080` for a server on the same host, or an internal address such
as `http://llama.internal.example.com:8080`.

Make sure the endpoint is **network-restricted** — bound to localhost or an
internal network, protected by a firewall — and not exposed to the public
internet.

## 2. Point the provider at the server

1. Log in as a user with permission to administer AI providers.
2. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and open
   the **llama.cpp** provider settings.
3. Enter the server's **base URL**.
4. Save.

## 3. Use it

Choose **llama.cpp** wherever the AI module offers a provider choice — for example
as the default chat provider, or on an individual AI feature. Because it speaks the
OpenAI API shape, OpenAI-style flows work against the local endpoint, with prompt
data staying entirely on infrastructure you control and no per-token vendor cost.
