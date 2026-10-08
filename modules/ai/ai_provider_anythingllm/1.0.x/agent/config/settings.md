<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — connection settings, config, DB schema

## Install & enable

```bash
composer require drupal/ai_provider_anythingllm
drush en ai_provider_anythingllm -y
```

Composer pulls `drupal/ai ^1.1`, `drupal/key ^1.18`, `drupal/search_api ^1.34`,
`league/html-to-markdown ^5.1`, `league/commonmark ^2`. The `.info.yml` declares only `ai:ai` and
`key:key` as Drupal dependencies; `search_api` is a Composer requirement and is needed at runtime by
the Search API backend plugin (enable it too if it is not already on).

You also need a running AnythingLLM instance and an AnythingLLM API key
(`<host>/settings/api-keys`).

## Settings form

- Route **`ai_provider_anythingllm.settings_form`** → `/admin/config/ai/providers/anythingllm`,
  `_permission: 'administer ai providers'`, form `Form\AnythingllmConfigForm`. Menu link
  `ai_provider_anythingllm.settings_menu` under `ai.admin_providers`.
- Editable config: **`ai_provider_anythingllm.settings`**.

Fields (`buildForm()`):

| Field | Type | Config key | Notes |
|---|---|---|---|
| API Url | textfield | `api_url` | URL + port of the AnythingLLM API, e.g. `http://127.0.0.1:3001`. Required. |
| AnythingLLM API Key | `key_select` | `api_key` | A Key entity id holding the API key. |

The form also embeds the AI module's models table (`ai.form_helper`→`getModelsTable()`), where each
AnythingLLM workspace is listed as a model and per-model options are set (see
[plugins/provider.md](../plugins/provider.md)).

`validateForm()` loads the Key value, injects URL+key into `AnythingllmApi`, and calls `getModels()`
(a live `GET /api/v1/workspaces`) — a failure errors "The API Key is not working", so a bad
host/key cannot be saved. `submitForm()` writes `api_key` and `api_url`.

## Config object & schema

`config/install/ai_provider_anythingllm.settings.yml`:

```yaml
api_url: ''
api_key: ''
```

Schema `config/schema/ai_provider_anythingllm.schema.yml` types the object with `api_url` (string,
required) and `api_key` (string, required). `api_key` stores a Key entity **id**, not the secret —
the secret lives in the Key provider and is absent from config exports.

## How the client uses config

`AnythingllmApi` (service `ai_provider_anythingllm.api`, args `@http_client`, `@key.repository`,
`@config.factory`) reads `api_url` directly and resolves `api_key` through `key.repository`
(`setConnection()`), sending the key as `Authorization: Bearer …`. Requests go through the core
Guzzle `http_client`; `call()` sets `connect_timeout` 120 / `read_timeout` 300 and no TLS-related
option (verification stays at the Guzzle default, on). Every endpoint is `api_url . '/api/v1/' .
$endpoint`.

## Database table

`hook_schema()` (`ai_provider_anythingllm.install`) defines table **`ai_provider_anythingllm`**:
`search_api_id` (varchar 255, primary key) and `data` (text). It maps a Search API item id to the
JSON list of AnythingLLM document names uploaded for it, so attachments can be cleaned up on
re-index/delete. All access is via `AnythingllmItemRepository` (`ai_provider_anythingllm.repository`)
using the database API's insert/update/upsert/delete/select builders (parameterized — no raw SQL).

## Operation types

`ai_provider_anythingllm.module` adds an `ai_search_api` operation type via
`hook_ai_operation_types_alter()`. `hook_install()`/uninstall are not defined beyond the schema; no
default models are seeded (workspaces are discovered live from the API).
