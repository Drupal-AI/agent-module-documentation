# Configuration

Configuring the Ollama provider is deliberately simple: tell Drupal where your
Ollama server is, then pick which model handles each operation type.

## Open the settings form

1. Log in as a user with the **Administer AI providers** permission (this comes
   from the AI module).
2. Go to **Configuration → AI → Providers → Ollama**, or navigate directly to
   `/admin/config/ai/providers/ollama`.

## The two settings

- **Host Name** *(required)* — the base URL of your Ollama server, **including the
  protocol**. For a server on the same machine that's `http://127.0.0.1`. For
  Drupal running in DDEV/Docker with Ollama on your host machine, use
  `http://host.docker.internal` (see below).
- **Port** — the port Ollama listens on. Ollama's default is **11434**, and the
  form pre‑fills that value. Leaving it empty means the standard 80/443.

Below those fields the AI module renders a **models table**, where you map each
operation type to the models your Ollama instance has pulled.

### The form checks the connection before it saves

When you save, the form actually connects to the host/port you entered and lists
the models. If it cannot reach the server it refuses to save and shows *"Could not
connect to the host. Please check the host name and port."* — so a bad host can't
be stored silently.

## Making the DDEV / Docker case work

When Drupal runs inside a container, "localhost" means the container, not your
host machine — so you must make Ollama reachable and point Drupal at the host:

1. On your host, run Ollama so it listens beyond localhost, and pull the models
   you need:

   ```bash
   OLLAMA_HOST=0.0.0.0:11434 ollama serve
   ollama pull llama3            # chat
   ollama pull nomic-embed-text  # embeddings
   ollama pull llama-guard3      # moderation (see below)
   ```

2. Prove the container can reach Ollama before touching Drupal:

   ```bash
   ddev exec 'curl -s http://host.docker.internal:11434/api/tags | head -c 200'
   ```

3. In the settings form set **Host Name** to `http://host.docker.internal` and
   **Port** to `11434`.

## Choosing models

- The provider supports three operation types: **chat**, **embeddings**, and
  **moderation**. Map a model to each in the models table.
- **Moderation is restricted.** Only **Llama Guard 3** (`llama-guard3`) and
  **ShieldGemma** (`shieldgemma`) work for moderation; the moderation model list
  is filtered to those, and any other model produces "Model not supported for
  moderation."
- **Newly pulled models don't appear instantly.** Drupal caches the model list. If
  you `ollama pull` a new model, re‑save the settings form (or clear the cached
  list) before it shows up in Drupal.

## Finish in the AI module's settings

After the provider is configured, choose it as the default provider (and pick the
model) for each operation type in the AI module's own settings at **Configuration
→ AI → Settings** (`/admin/config/ai/settings`). That is where the rest of Drupal
actually starts using Ollama.

## Good to know

- **No authentication.** There is no API key — reachability of the host/port is
  the entire access boundary. Keep the Ollama server on a trusted network.
- **Timeouts.** Listing models on the settings form times out fast (about 5
  seconds), while chat/embeddings requests allow up to 120 seconds — long enough
  for slow local generation, but a hung model can tie up a PHP worker for that
  time.
- **A harmless config quirk.** Each save also writes a stray, empty `api_key`
  value into the provider's configuration even though there is no such field. It
  does nothing at runtime but may be flagged by config‑schema checking tools; you
  can delete it (`drush cdel ai_provider_ollama.settings api_key -y`), though it
  returns on the next save.
