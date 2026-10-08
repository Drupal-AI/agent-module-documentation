# configure — settings, providers, keys

Config UI: **/admin/config/ai/settings** (route `ai.settings_form`). Requires the
`administer ai` permission. Provider-specific settings live at
**/admin/config/ai/providers** (`administer ai providers`).

## API keys go through the Key module

`ai` depends on `key`. Never put a vendor API key in config or settings.php. Store the key
as a Key entity (env-provider recommended) and select it in the provider's settings form.
Each provider module (e.g. `ai_provider_openai`) adds its own settings form where you pick
the Key and default models.

## `ai.settings` config keys (config/install/ai.settings.yml)

| Key | Default | Meaning |
|---|---|---|
| `default_providers` | `{}` | map of operation type → `{provider_id, model_id}` (the site defaults) |
| `prompt_logging` | `false` | log the full prompt sent to providers |
| `prompt_logging_tags` | `''` | only log requests carrying these tags |
| `request_timeout` | `60` | seconds before an AI HTTP request times out |
| `allowed_hosts` | `[]` | allow-list of outbound hosts providers may call (security) |
| `allowed_hosts_rewrite_links` | `false` | rewrite links to allowed hosts |
| `global_guardrails` | `[]` | guardrail sets applied to every request site-wide |

## Setting defaults with drush

```bash
# Inspect current AI settings.
drush config:get ai.settings

# Set the default chat provider+model (structure is nested under default_providers.<op>).
drush config:set ai.settings default_providers.chat.provider_id openai -y
drush config:set ai.settings default_providers.chat.model_id gpt-4o -y

# Tighten security: only allow calls to your provider's host.
drush config:set ai.settings allowed_hosts.0 api.openai.com -y
```

Prefer configuring providers through their own forms at `/admin/config/ai/providers` so the
Key selection and model lists validate against what the provider actually supports; use the
raw `config:set` above only when scripting a known-good value.

## Config entities this module defines

- `ai_prompt` / `ai_prompt_type` — reusable prompt library (permission: `manage ai prompts`,
  `administer ai prompt types`).
- `ai_guardrail` / `ai_guardrail_set` — pre/post-processing policy applied to requests
  (permission: `administer guardrails`, `administer guardrail sets`); reference sets from
  `global_guardrails` to apply everywhere. See [extend/ai.md](../extend/ai.md).

## Content entity

- `ai_file` — an AI-generated file (e.g. a generated image). Overview at the AI Files listing
  (`access ai files overview`); per-item view/delete gated by the `* ai file(s)` permissions.
