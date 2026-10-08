<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Perplexity provider — configuration

## Install & enable

```
composer require drupal/ai drupal/key
drush en ai key ai_perplexity -y
```

The project ships no `composer.json`; its deps (`ai`, `key`) come from `ai_perplexity.info.yml`.
Create a Perplexity API key at perplexity.ai, store it in a Key entity
(`/admin/config/system/keys`), then select it on the provider form.

## Settings form

- Route `ai_perplexity.settings` → `/admin/config/ai/providers/perplexity`
  (`src/Form/PerplexitySettingsForm.php`, form id `perplexity_settings`, extends
  `ConfigFormBase`).
- Requirement: **`_permission: 'administer ai providers'`**.
- Menu link `ai_perplexity.settings` under `ai.admin_providers`.

Fields:

| Field | `#type` | Config key | Notes |
|-------|---------|-----------|-------|
| Perplexity AI API Key | `key_select` | `api_key` | selects a Key entity |
| Default Model | `select` (required) | `default_model` | the 3 Sonar online models |
| Temperature | `number` (0-2, step 0.1) | `temperature` | default 0.2 |
| Top P | `number` (0-1, step 0.1) | `top_p` | default 0.9 |
| Max Tokens | `number` (1-4096) | `max_tokens` | default 1000 |

`submitForm()` saves the five keys to `ai_perplexity.settings` and calls
`AiProviderPluginManager::defaultIfNone('chat', 'perplexity', <default_model>)`.

## Config objects & schema

`config/schema/ai_perplexity.schema.yml` defines two types:

- **`ai_perplexity.settings`** (`config_object`): `api_key` (string), `default_model` (string),
  `temperature` (float), `top_p` (float), `max_tokens` (int), `request_timeout` (int),
  `max_retries` (int), `retry_delay` (int). The form exposes only the first five; the timeout /
  retry keys are read by the plugin but are not on the form (set via config import/drush).
- **`ai.provider.perplexity`** (extends `ai_provider.plugin`): per-provider model settings
  (`model`, `temperature`, `top_p`, `max_tokens`, `request_timeout`, `max_retries`,
  `retry_delay`).

No `config/install/*` ships, so there are no packaged default values (defaults come from the
form `#default_value` and the `?? ...` fallbacks in the plugin).

## Key handling

Config stores only the Key entity machine name. `PerplexityProvider::loadApiKey()` resolves the
secret through `KeyRepositoryInterface::getKey($key_id)->getKeyValue()` and passes it to the
OpenAI SDK `withApiKey()`. Use an env/file Key provider to keep the secret out of exported config.

## HTTP client

`PerplexityProvider::loadClient()` builds its own `GuzzleHttp\Client` with
`['timeout' => request_timeout ?? 120, 'connect_timeout' => 10]` and hands it to
`\OpenAI::factory()->withApiKey(...)->withBaseUri('https://api.perplexity.ai')
->withHttpClient($guzzleClient)`. The base URI is hard-coded (no admin-settable host), and the
standard Guzzle client makes the outbound call.
