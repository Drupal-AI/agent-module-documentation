# Configure Groq (settings form + config)

One settings form provides the API key and the default request tuning. There is no per-field or
per-content-type configuration — everything lives in two config objects.

- Route: `ai_provider_groq.settings_form` → path `/admin/config/ai/providers/groq`
  (runtime-verified). Title "Setup Groq Authentication".
- Permission: **`administer ai providers`** (owned by `drupal/ai`, not this module).
- Menu link: `ai_provider_groq.settings_menu` ("Groq Configuration"), under `ai.admin_providers`.
- Form class: `Drupal\ai_provider_groq\Form\GroqConfigForm` (`src/Form/GroqConfigForm.php`),
  a `ConfigFormBase` editing `ai_provider_groq.settings` and `ai_provider_groq.overrides`.

## The API key (Key module)

The `api_key` field is a **`key_select`** element (`GroqConfigForm.php:99`) — it lists Key entities
from the **`key`** module (a hard dependency in `info.yml`). What is stored in
`ai_provider_groq.settings:api_key` is the **Key entity's machine name**, not the secret. The raw
token is resolved only at request time by the base client via
`keyRepository->getKey(<id>)->getKeyValue()`
(`Drupal\ai\Base\AiProviderClientBase::loadApiKey()`).

So the recommended setup keeps the secret out of exported config entirely: create a Key backed by an
environment variable (Key's `env` provider), then point this form at it. Get your token at
`https://console.groq.com/keys`.

```bash
# secret lives in an env var, referenced by a Key entity
ddev drush key:save groq_api_key --label='Groq API Key' --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"GROQ_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
# then set the provider config to reference that key:
ddev drush config:set ai_provider_groq.settings api_key groq_api_key -y
```

## `ai_provider_groq.settings` (config object)

Install defaults: `config/install/ai_provider_groq.settings.yml`. Schema:
`config/schema/ai_provider_groq.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | Machine name of the Key entity holding the Groq token (schema marks it `required`). |
| `reasoning_format` | string | `hidden` | How reasoning is returned: `parsed` (separate field), `raw` (`<think>` tags in content), `hidden` (final answer only). Only affects reasoning-capable models (`-qwq-`, `deepseek`). |
| `temperature` | float | `0.6` | Sampling randomness, form-clamped 0.0–2.0. |
| `max_tokens` | integer | `1024` | Max tokens in the completion. |
| `json_mode` | boolean | `false` | Ask the model for structured JSON output. |

These four (excluding `api_key`) are the **default fallback settings** applied to every Groq request
unless an operation override exists.

## `ai_provider_groq.overrides` (per-operation overrides)

Schema: `config/schema/ai_provider_groq.overrides.yml`. Single key `operation_overrides`: a sequence
**keyed by AI operation id** (e.g. `chat`, `chat_with_complex_json`), each a mapping of the same four
keys (`reasoning_format`, `temperature`, `max_tokens`, `json_mode`).

The form only renders an override sub-fieldset for operations where `ai.settings:default_providers`
already selects `groq` as the provider (`GroqConfigForm.php:120`). Ticking "Override default settings
for this operation" persists that operation's mapping; unticking removes it. At request time
`GroqProvider::getOperationSettings()` merges the matching override over the fallback defaults.

```yaml
# ai_provider_groq.overrides
operation_overrides:
  chat:
    reasoning_format: hidden
    temperature: 0.3
    max_tokens: 2048
    json_mode: false
```

## Notices added elsewhere

`ai_provider_groq_form_ai_settings_alter()` (`ai_provider_groq.module`) adds a small notice under the
`chat` and `chat_with_complex_json` model selectors on the core AI settings form, linking here when
`groq` is chosen. Purely informational.

## Install-time migration

`ai_provider_groq_install()` copies an old `provider_groq.settings:api_key` (from the former in-core
AI submodule) into `ai_provider_groq.settings` if the new config is still empty, then uninstalls the
legacy `provider_groq` submodule. Only relevant when upgrading from that older layout.
