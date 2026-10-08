<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Langdock provider — configuration

## Install & enable

```
composer require drupal/ai_provider_langdock
drush en ai_provider_langdock -y
```

Pulls `drupal/ai ^1.2.0` and `drupal/key ^1.18`. Enabling `ai` and `key` is required.

## Settings form

- Route `ai_provider_langdock.settings_form` → `/admin/config/ai/providers/langdock`
  (`src/Form/SettingsForm.php`, form id `langdock_settings`, extends `ConfigFormBase`).
- Requirement: **`_permission: 'administer ai providers'`** (the AI-module permission).
- Menu link `ai_provider_langdock.settings_menu` under parent `ai.admin_providers`.

Fields (both `#required`):

| Field | `#type` | Config key | Notes |
|-------|---------|-----------|-------|
| Langdock API Key | `key_select` | `api_key` | selects a Key entity, not the raw secret |
| Endpoint | `textfield` | `host` | placeholder `https://api.langdock.com/openai/eu/v1` |

`validateForm()` loads the selected key via `KeyRepositoryInterface::getKey(...)->getKeyValue()`,
instantiates the `langdock` provider, calls `setAuthentication()` + `setEndpoint()` with the
entered host, and calls `getConfiguredModels()` as a live connectivity/credential check; failure
sets a form error. `submitForm()` writes `api_key` and `host` to `ai_provider_langdock.settings`
then calls `setDefaultModels()` → `AiProviderPluginManager::defaultIfNone()` for each entry in
`getSetupData()['default_models']` (chat `gpt-5.2`, embeddings `text-embedding-ada-002`).

## Config object

`ai_provider_langdock.settings`:

- `api_key` — machine name of a Key entity (Key module).
- `host` — base URL of the Langdock OpenAI-compatible endpoint; consumed by
  `LangdockProvider::loadClient()` via `setEndpoint()` and by `getEndpoint()`.

No `config/schema/*` and no `config/install/*` ship, so there are no packaged defaults and no
typed-config schema for these keys.

## Key handling

The provider never stores the raw secret in its own config — only the Key entity's machine name.
At runtime `OpenAiBasedProviderClientBase::loadApiKey()` resolves it through the Key repository
and hands it to the OpenAI SDK's `withApiKey()`. Store the key with a Key provider such as *env*
or *file* so the secret stays out of exported configuration.

## HTTP client

The provider does not build its own HTTP client. The base class
(`Drupal\ai\Base\AiProviderClientBase::create()`) injects the client from
`http_client_factory->fromOptions([...])` (Drupal's Guzzle client, `timeout` from
`ai.settings:request_timeout`), and `createClient()` passes it to the OpenAI factory via
`withHttpClient()` — the standard Drupal HTTP client makes the outbound call to the
configured `host`.
