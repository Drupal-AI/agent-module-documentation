<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup wizard & configuration

## Install / enable

```bash
composer require drupal/ai_provider_dropsolidai
drush en ai_provider_dropsolidai
```

Composer pulls `drupal/ai` and `drupal/ai_provider_litellm` (hard deps). The wizard also helps you
install optional pieces: `ai_vdb_provider_postgres`, `langfuse` (+ `langfuse_ai_logging`) and
`ai_dropsolid`. PHP `>=8.1`.

## The form

`src/Form/DropsolidAiConfigForm.php` (`final ConfigFormBase`), route
**`ai_provider_dropsolidai.settings_form`** at `/admin/config/ai/providers/dropsolidai`,
requirement **`_permission: 'administer ai providers'`** (`…routing.yml`). Menu link
`…settings_link` and action link `…configure_action` both under `ai.admin_providers`.

Injected services (`create()`): `module_handler`, `extension.path.resolver`, **`key.repository`**,
core `http_client`, `ai.vdb_provider` (VDB plugin manager, when present), `langfuse.client` (when
present), and read-only config objects `ai_provider_litellm.settings`,
`ai_vdb_provider_postgres.settings`, `langfuse.settings`, plus the module's own logger channel.

The form renders a vertical-tab wizard with four component tabs, each offering install commands,
a link to that module's own settings, and an AJAX **test** button:

1. **LiteLLM AI Provider** (`testLiteLlm`) — reads `ai_provider_litellm.settings` (`api_key` Key id,
   `host`, `moderation`), resolves the key via `keyRepository->getKey(...)->getKeyValue()`, builds
   `\Drupal\ai_provider_litellm\LiteLLM\LiteLlmAiClient` with the core `http_client`, and calls
   `->models()`. Maps HTTP 401 → auth error, 400 budget_exceeded, 500 "Model List not loaded" to
   friendly messages.
2. **Vector Store (PostgreSQL)** (`testVectorStore`) — reads `ai_vdb_provider_postgres.settings`
   (`host`, `username`, `password` Key id, `default_database`, `port` default 5432), resolves the
   password key, creates the `postgres` VDB connector via `ai.vdb_provider`, calls
   `setCustomConfig([...])` then `->ping()`.
3. **Tracing (LangFuse)** (`testTracing`) — reads `langfuse.settings` (`langfuse_url`,
   `auth_method` — bearer_token / basic_auth / key_pair) and exercises the `langfuse.client`.
4. **AI Extras (ai_dropsolid)** — install guidance for custom tokenizers / reranking models.

`submitForm()` recomputes and saves the per-component `configured` / `tested` booleans (via
`isLiteLlmConfigured()`, `isLiteLlmTested()`, `isPostgresVdbConfigured()`, … helpers). Test
callbacks additionally cache `*.last_test_time` / `*.last_test_success` (cache TTL 3600s).

## Config object

`ai_provider_dropsolidai.settings` (schema `config/schema/…schema.yml`, `type: config_object`):
- `provider` mapping — `configured` (bool), `tested` (bool).
- `vdb` mapping — `configured` (bool), `tested` (bool).
- `tracing` mapping — `configured` (bool), `tested` (bool).

Install defaults (`config/install/…settings.yml`): every flag `false`. This object holds **only
status flags** — all credentials, hosts and endpoints stay in the component modules' own config
and in Key entities.

## Secrets

The module never stores or writes secrets. It reads existing secrets on demand from Key entities
(`key.repository`) belonging to LiteLLM (API key) and Postgres VDB (password), only for the
duration of a live connection test.

## SSO callback

`src/Controller/SsoCallbackController::handle()` is a placeholder: it flashes
"Dropsolid.ai single sign-on is not available yet." and redirects to the settings form. No route
in `…routing.yml` currently targets it.
