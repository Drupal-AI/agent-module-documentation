<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider settings form & config

## Install & enable

```bash
composer require drupal/ai_providers_api
drush en ai_providers_api -y
```

Core-only (Drupal 11). No other module dependencies.

## Settings form

Route `ai_providers_api.settings` → `/admin/ai-providers/settings`, class
`Form\AiSettingsForm` (extends `ConfigFormBase`, injects the provider manager).
Permission: **`administer ai providers`** (`restrict access: true`). Menu:
*Configuration → Web services → AI Settings*.

For each discovered provider the form shows a fieldset with an **Enable** checkbox
(AJAX). When enabled, the provider's own `buildConfigurationForm()` sub-form is embedded
(via `SubformState`) so you can set its fields — e.g. Claude/Gemini **API key**
(`#type password`, blank-to-keep) + **Model**, Ollama **Model**, and the shared optional
**API endpoint URL** override.

`submitForm()` writes, per provider, `providers.<id>.enabled` and (when enabled)
`providers.<id>.configuration` (from the plugin's `getConfiguration()` after its
`submitConfigurationForm()`), into config object `ai_providers_api.settings`.

## Config object & schema

`config/install/ai_providers_api.settings.yml` ships `providers: {}`.
`config/schema/ai_providers_api.schema.yml`:

- `ai_providers_api_provider_configuration` — `{ enabled: bool, configuration: { model,
  endpoint_url } }`.
- `ai_providers_api.settings` — `providers` sequence keyed by provider id
  (`ai_providers_api.provider.[%key]`).
- `ai_providers_api.provider.gemini` / `.claude` add an `api_key: string` to
  `configuration`.

Example:

```yaml
# ai_providers_api.settings
providers:
  gemini:
    enabled: true
    configuration:
      api_key: '…'
      model: gemini-2.5-flash-preview
      endpoint_url: ''
  ollama:
    enabled: true
    configuration:
      model: 'llama3.2:3b'
      endpoint_url: ''
```

## Using enabled providers

Only enabled providers should be dispatched to (`AiProviderManager::getEnabledDefinitions()`);
`AiService::prompt()`/`streamPrompt()` resolve a provider by id and merge its saved
`configuration` (see [../api/streaming.md](../api/streaming.md)). Sending to a provider id
with no plugin definition throws `AiException`.

## Testing

The `ai_providers_api_test` sub-module (in `tests/`) ships a `dummy` provider driven by
Drupal state (`dummy_ai_provider_output` map, `dummy_ai_provider_throw` bool) for
kernel/functional tests — not for production.
