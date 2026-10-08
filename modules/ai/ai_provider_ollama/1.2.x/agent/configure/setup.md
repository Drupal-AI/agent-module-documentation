<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up the Ollama provider

## Install

```bash
composer require drupal/ai_provider_ollama     # requires drupal/ai ^1.2.0
drush en ai_provider_ollama -y
```

If the site previously used the AI module's bundled `provider_ollama` submodule,
`hook_install()` copies `provider_ollama.settings` into `ai_provider_ollama.settings` (only when
the new object has no `host_name` yet) and uninstalls the old submodule — no manual migration.

## Configure

Form: `/admin/config/ai/providers/ollama` (`ai_provider_ollama.settings_form`, permission
`administer ai providers`).

| Field | Config key | Notes |
|---|---|---|
| **Host Name** (required) | `host_name` | Include the protocol: `http://127.0.0.1`. In DDEV/Docker use `http://host.docker.internal` to reach an Ollama running on the host machine. |
| **Port** | `port` | Empty means 80/443. Ollama's default is **11434** (the form pre-fills that value). |
| Models table | — | Rendered by the AI module (`ai.form_helper`); maps operation types to models. |

The form **validates by connecting**: `validateForm()` instantiates the `ollama` provider with the
submitted host/port and calls `getConfiguredModels()`; failure sets the error *"Could not connect
to the host. Please check the host name and port."* so a bad host cannot be saved.

```bash
drush cget ai_provider_ollama.settings
drush cset ai_provider_ollama.settings host_name 'http://host.docker.internal' -y
drush cset ai_provider_ollama.settings port 11434 -y
drush cr
```

**Known bug:** `submitForm()` also does `->set('api_key', $form_state->getValue('api_key'))`
although the form has no `api_key` element and the schema declares none, so each save writes
`api_key: null` into the config object. Harmless at runtime, but it will be reported by config
schema checks — delete it if it bothers you:

```bash
drush cdel ai_provider_ollama.settings api_key -y   # comes back on the next form save
```

## Making the DDEV case work end to end

Inside the web container Drupal must reach the host's Ollama:

```bash
# On the host: make sure Ollama listens beyond localhost.
OLLAMA_HOST=0.0.0.0:11434 ollama serve
ollama pull llama3
ollama pull nomic-embed-text     # embeddings
ollama pull llama-guard3         # moderation (see below)

# From inside the container, prove connectivity before touching Drupal:
ddev exec 'curl -s http://host.docker.internal:11434/api/tags | head -c 200'
```

Then set `host_name: http://host.docker.internal`, `port: 11434`.

## Model discovery and caching

`getConfiguredModels()` calls `GET api/tags` and caches the result in **state**
`ai_provider_ollama.models` (a map of machine name → model name). Consequences:

- Pulling a new model on the Ollama server does **not** immediately show it in Drupal; re-save the
  settings form or clear the state entry.
- For `operation_type = moderation` the list is filtered to models whose root name (before the
  first `:`) is `shieldgemma` or `llama-guard3`.
- On failure the method degrades gracefully: it logs to the `ai_provider_ollama` channel, shows an
  error message to users with `administer ai providers`, and returns an empty list — so an
  unreachable server looks like "no models" rather than a fatal error.

```bash
drush sget ai_provider_ollama.models
drush sdel ai_provider_ollama.models     # force rediscovery
```

`hook_uninstall()` deletes that state key.

## Timeouts

`OllamaControlApi::makeRequest()` uses **5 s** connect/total timeout for `api/tags` (so the
settings form fails fast) and **120 s** connect/read/total for everything else — long enough for a
slow local generation, but note a hung model will hold a PHP worker for two minutes.

## Verify it works

```bash
drush php:eval '
$p = \Drupal::service("ai.provider")->createInstance("ollama");
print_r($p->getConfiguredModels());
'
```

Then set the default provider/model for each operation type in the AI module's own settings
(`/admin/config/ai/settings`).
