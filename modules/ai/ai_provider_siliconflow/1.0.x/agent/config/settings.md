<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siliconflow provider — configuration

## Install & enable

```
composer require drupal/ai_provider_siliconflow
drush en ai_provider_siliconflow -y
```

Pulls `drupal/ai ^1.0.0-beta1` and `drupal/key ^1.18`.

`hook_install()` (`ai_provider_siliconflow.install`) migrates any `api_key` from the legacy
in-`ai` submodule config `provider_siliconflow.settings` into `ai_provider_siliconflow.settings`
(only if the new one has no key yet) and uninstalls the old `provider_siliconflow` module if
present.

## Settings form

- Route `ai_provider_siliconflow.settings_form` → `/admin/config/ai/providers/siliconflow`
  (`src/Form/SiliconflowConfigForm.php`, form id `siliconflow_settings`, extends
  `ConfigFormBase`; injects `ai.form_helper` + `ai.provider`).
- Requirement: **`_permission: 'administer ai providers'`**.
- Menu link `ai_provider_siliconflow.settings_menu` under `ai.admin_providers`.

Fields:

| Field | `#type` | Config key | Notes |
|-------|---------|-----------|-------|
| Siliconflow Access Token | `key_select` | `api_key` | selects a Key entity; links to siliconflow.co token page |
| Models table | via `AiProviderFormHelper::getModelsTable()` | `models` | per-operation model rows |

`submitForm()` collects any `model__<type>__<n>` values into a `models` map and saves it with
`api_key` to `ai_provider_siliconflow.settings`. `addMoreModel()` / `addMoreModelCallback()`
support AJAX "add another model" rows.

Each model row adds a `siliconflow_endpoint` textfield (see
`SiliconflowProvider::loadModelsForm()`) — the SiliconFlow model name for shared inference, or a
full `https://…` URL for a dedicated endpoint — with
`#autocomplete_route_name: ai_provider_siliconflow.autocomplete.models`.

## Autocomplete route

`ai_provider_siliconflow.autocomplete.models` → `/admin/ai/siliconflow/autocomplete/models`
(`_format: json`), guarded by **`_permission: 'autocomplete siliconflow model list'`**
(`ai_provider_siliconflow.permissions.yml`). `SiliconflowAutocomplete::models()` reads
`model_type` and `q` from the query, and when `q` is longer than 2 chars, GETs the **fixed** URL
`https://api.siliconflow.cn/v1/models?sub_type=<model_type>` via `\Drupal::httpClient()` with an
`Authorization: Bearer <token>` header (token from the configured Key), then returns the model
ids that contain `q` as a JSON array. The queried host is fixed in code (only the `sub_type`
query value comes from the request).

## Config object & schema

- `config/install/ai_provider_siliconflow.settings.yml` seeds `api_key: ''`.
- `config/schema/ai_provider_siliconflow.schema.yml` types `ai_provider_siliconflow.settings`
  as a `config_object` with `api_key` (string, required). The `models` map written by the form
  is not covered by an explicit schema entry.

## Key handling

Config stores only the Key entity machine name. `AiProviderClientBase::loadApiKey()` (and the
autocomplete controller, via `key.repository`) resolve the secret and send it as an
`Authorization: Bearer` header. Use an env/file Key provider to keep the token out of exported
config.

## HTTP client

The `SiliconflowApi` service is constructed with the Drupal `@http_client` (Guzzle). Its
`makeRequest()` sets `connect_timeout`/`read_timeout` (120s) and the `Authorization` header, and
issues the request through the standard Guzzle client. Base URLs are fixed in the class
(`https://api.siliconflow.cn/v1`, plus `https://siliconflow.co/...` for model/user lookups);
`finalEndpoint()` treats an admin-entered value beginning with `http(s)://` as a dedicated
endpoint URL, otherwise appends it to the serverless base.
