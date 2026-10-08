<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moonshot AI provider — configuration

## Install & enable

```
composer require drupal/ai_provider_moonshot
drush en ai_provider_moonshot -y
```

Pulls `drupal/ai ^1.1.0`, `drupal/key ^1.18`, `openai-php/client >=v0.10.1`.

Then (per README): create a Key at `/admin/config/system/keys/add`, and select it at
`/admin/config/ai/providers/moonshot`.

## Settings form

- Route `ai_provider_moonshot.settings_form` → `/admin/config/ai/providers/moonshot`
  (`src/Form/SettingsForm.php`, form id `ai_provider_moonshot_settings`, extends
  `ConfigFormBase`).
- Requirement: **`_permission: 'administer ai providers'`**.
- Menu link `ai_provider_moonshot.settings` under `ai.admin_providers` (weight 10).

Fields (both `#required`):

| Field | `#type` | Config key | Notes |
|-------|---------|-----------|-------|
| API Key | `key_select` | `api_key` | `#key_filters: {type: authentication}` — selects a Key entity |
| API Host | `textfield` | `host` | default `https://api.moonshot.cn/v1` |

A collapsible *Help* details element links to the Moonshot API docs. `submitForm()` writes
`api_key` and `host` to `ai_provider_moonshot.settings`. There is no `validateForm()` /
connectivity test and no default-model seeding on this form.

## Config object

`ai_provider_moonshot.settings`:

- `api_key` — machine name of a Key entity.
- `host` — base URL of the Moonshot OpenAI-compatible endpoint; consumed by
  `MoonshotProvider::loadClient()`.

No `config/schema/*` or `config/install/*` ship, so these keys are untyped and have no packaged
defaults (the form supplies the `https://api.moonshot.cn/v1` default at build time).

## Key handling

The provider config stores only the Key entity's machine name. At runtime
`AiProviderClientBase::loadApiKey()` resolves the secret through the Key repository and passes it
to the OpenAI SDK `withApiKey()`. Use an env/file Key provider to keep the secret out of exported
config.

## HTTP client

`MoonshotProvider::loadClient()` builds the OpenAI client with
`\OpenAI::factory()->withApiKey(...)->withBaseUri($host)->withHttpClient($this->httpClient)`.
`$this->httpClient` is the Drupal client injected by the base class
(`http_client_factory->fromOptions([...])`), so the outbound call to the configured `host` uses
the standard Drupal Guzzle client. (Note: line
`$client->withBaseUri($this->getConfig()->get('host'))` discards its return value — an
immutable-builder no-op — so the effective base URI is the earlier `$host` from
`$this->config->get('host')`.)
