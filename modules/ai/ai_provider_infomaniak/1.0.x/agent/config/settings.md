<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Infomaniak AI Provider — configuration

## Install / enable

```
composer require drupal/ai_provider_infomaniak
drush en ai ai_provider_infomaniak -y
drush cr
```

Requires `drupal/ai` (`^1.2.4`), `drupal/key`, the `openai-php/client` library and PHP 8.1+, plus an
Infomaniak account with AI Tools enabled.

## Credentials needed

- **API token** with the `ai-tools` scope, created in the Infomaniak Manager. Store it in a **Key
  entity** (drupal/key) and select it in the form.
- **Product ID** — the numeric AI Tools product id (e.g. `123456`).

## Config objects

- **`ai_provider_infomaniak.settings`** (`InfomaniakConfigForm::CONFIG_NAME`; schema type
  `ai_provider.infomaniak`). Keys:
  - `api_key` — machine name of the Key entity holding the token (chosen via `key_select`; the token
    value itself is not stored here).
  - `product_id` — numeric product id (textfield).
  - `base_url` — API base (install default `https://api.infomaniak.com/2/ai`; the form's field
    default and the text-to-image path use the `1/ai` variant — see plugins/provider.md).
  - `organization` — optional org identifier.
  - `timeout` — request timeout in seconds (default 60, 1–300).
  - `models` — per-model overrides written by `ModelEditForm` under `models.<id-with-slashes-as-_>`.
- **`ai_provider_infomaniak.models`** (`config/install/…models.yml`; schema
  `ai_provider_infomaniak.models`) — the predefined catalogue: a `definitions` sequence of
  `{id, name, type, operation_type}` used by `InfomaniakProvider::getConfiguredModels()` and the
  models table.

## How the API token is used

`InfomaniakProvider::loadAuthentication()` calls the base-class `loadApiKey()` to resolve the Key and
reads `product_id` from config. The token is passed to the OpenAI client via `->withApiKey(...)`; the
form's `loadApiKeyValue()` resolves the Key value only to run the "Test Connection" check. The token
value is never echoed to the page — the connection panels display only the endpoint and product id
(both `htmlspecialchars()`-escaped).

## Endpoint construction

`buildEndpointUrl()` → `sprintf('%s/%s/openai/v1', rtrim(base_url,'/'), product_id)` for
chat/embeddings. Text-to-image builds its own v1 endpoint
`https://api.infomaniak.com/1/ai/{product_id}/openai` with a one-time OpenAI client.

## Routes & permissions

- `ai_provider_infomaniak.settings_form` → `/admin/config/ai/providers/infomaniak`, permission
  `administer ai providers`.
- `ai_provider_infomaniak.edit_model` → `/admin/config/ai/providers/infomaniak/edit-model`
  (`?model_id=…` query param, used because model ids can contain slashes), permission
  `administer ai providers`.
- No `_access: TRUE` routes; both configuration routes are gated by the AI module's admin permission.
- `autocomplete infomaniak model list` permission is declared but unused (no matching route).

## Per-model editor

`ModelEditForm` (reached via the Edit link in the models table) tunes a single model: `temperature`
(0–2), `max_tokens` (1–32768), `top_p` (0–1), `frequency_penalty` (-2–2), `presence_penalty` (-2–2),
saved under `ai_provider_infomaniak.settings:models.<id>`. On save, `InfomaniakConfigForm::submitForm`
clears the provider model cache and sets default models per operation type
(`getSetupData()` → `defaultIfNone()`).
