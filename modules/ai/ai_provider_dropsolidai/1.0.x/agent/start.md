<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Provider: Dropsolid AI (ai_provider_dropsolidai) — agent index

A **setup wizard / configuration hub** for connecting Drupal's AI stack to the **Dropsolid AI
platform** (a managed OpenAI-compatible LLM gateway). It ships **no AiProvider plugin of its
own** — the actual provider connection is delivered by the required **`ai_provider_litellm`**
module, which this wizard configures and tests. Package `AI`. Core `^10 || ^11`. PHP `>=8.1`.
License GPL-2.0-or-later. Version 1.0.1-alpha1.

Depends on `ai:ai` and `ai_provider_litellm:ai_provider_litellm`. Optional (installed via the
wizard, not hard deps): `ai_vdb_provider_postgres`, `langfuse` / `langfuse_ai_logging`,
`ai_dropsolid`.

- **The setup wizard: tabs, config object, connection tests, secret handling** →
  [config/settings.md](config/settings.md)

## What it actually is

- A single admin form `DropsolidAiConfigForm` (`final ConfigFormBase`, form id via
  `getFormId()`), in `src/Form/DropsolidAiConfigForm.php` — a vertical-tab wizard with four
  sections: LiteLLM provider, PostgreSQL vector store, LangFuse tracing, Dropsolid AI extras.
- One route **`ai_provider_dropsolidai.settings_form`** at
  `/admin/config/ai/providers/dropsolidai`, requirement
  **`_permission: 'administer ai providers'`**. Menu link + action link under
  `ai.admin_providers`.
- `SsoCallbackController::handle()` (`src/Controller/`) is a **placeholder** — it only flashes a
  "single sign-on is not available yet" warning and redirects to the settings form; no route
  currently maps to it.
- One service: `logger.channel.ai_provider_dropsolidai`. `.module` file is empty (declare only).

## Config & mechanism (from source)

- Config object **`ai_provider_dropsolidai.settings`** (schema `config/schema/…`, install defaults
  all `false`) stores only per-component status: `provider.{configured,tested}`,
  `vdb.{configured,tested}`, `tracing.{configured,tested}` (plus runtime `last_test_time` /
  `last_test_success`). It stores **no secrets** and **no endpoints** — those live in the
  respective component modules' own config.
- The form reads other modules' config via injected read-only config objects
  (`ai_provider_litellm.settings`, `ai_vdb_provider_postgres.settings`, `langfuse.settings`) and
  resolves API keys / DB passwords through **`key.repository`** (Key module).
- AJAX "test" callbacks build a `LiteLlmAiClient` (`->models()`), a `postgres` VDB connector
  (`->ping()`), or exercise the `langfuse.client`, using core `http_client`; results are cached
  (`CACHE_TTL` 3600) and rendered as status/warning/error messages.

Deeper detail on each tab, the config keys, and the test flow is in
[config/settings.md](config/settings.md).
