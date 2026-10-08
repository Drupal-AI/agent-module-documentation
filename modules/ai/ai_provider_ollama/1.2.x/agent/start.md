<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ollama Provider (ai_provider_ollama) — agent index

Registers a local Ollama server as an AI provider for the **AI** module (`drupal/ai ^1.2.0`).
Config form `/admin/config/ai/providers/ollama` (`ai_provider_ollama.settings_form`, permission
**`administer ai providers`** — owned by the AI module). No permissions, no Drush of its own.

- **Host/port setup, DDEV specifics, model selection, verification** →
  [configure/setup.md](configure/setup.md)
- **The provider plugin, operation types, moderation model rules, control API** →
  [api/provider.md](api/provider.md)

Key facts:
- Plugin `#[AiProvider(id: 'ollama', label: 'Ollama')]`, class `OllamaProvider extends
  OpenAiBasedProviderClientBase` — chat/embeddings go through the AI module's OpenAI-compatible
  client because Ollama exposes an OpenAI-compatible API.
- Supported operation types: **`chat`, `embeddings`, `moderation`** (`getSupportedOperationTypes()`).
- **No authentication**: `hasAuthentication()` returns FALSE, `setAuthentication()` only nulls the
  client. There is no API key and no Key-module integration — reachability of `host_name:port` is
  the entire access boundary.
- Config object `ai_provider_ollama.settings`: `host_name` (string, required),
  `port` (integer, optional; the form defaults the displayed value to `11434`).
- Service `ai_provider_ollama.control_api` (`OllamaControlApi`, wraps `http_client`) calls
  Ollama's native endpoints: `GET api/tags` (installed models), `POST api/show`
  (embedding vector size + context size), `POST api/embeddings`, `POST api/chat`.
- Moderation parses the model's reply with per-model rule classes — `llama-guard3` →
  `Models\Moderation\LlamaGuard3`, `shieldgemma` → `Models\Moderation\ShieldGemma`. The match is
  on the model id **before the first `:`**; anything else throws
  `AiRequestErrorException('Model not supported for moderation.')`.
- `definitions/api_defaults.yml` declares the chat parameters the AI module exposes
  (`max_tokens` 1024, `temperature` 1 [0–2], `frequency_penalty`, `presence_penalty`, …).
- `hook_install()` copies `provider_ollama.settings` (the AI module's former bundled submodule)
  into `ai_provider_ollama.settings` when the new config is still empty, then uninstalls
  `provider_ollama`. `hook_uninstall()` deletes state key `ai_provider_ollama.models`.
- **Bug to know:** `OllamaConfigForm::submitForm()` writes
  `->set('api_key', $form_state->getValue('api_key'))` although no `api_key` element exists in the
  form and none is declared in the config schema — every save stores a stray `api_key: null` and
  will trip config-schema validation tooling.
