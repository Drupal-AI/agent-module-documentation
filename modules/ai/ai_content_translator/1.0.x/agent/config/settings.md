<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object, token storage and permissions

## Install & enable

```bash
composer require drupal/ai_content_translator
drush en ai_content_translator -y
```

Core dependencies: **`language`**, **`content_translation`**, **`locale`**
(`ai_content_translator.info.yml`). Requires Drupal **11.1+** and PHP **>=8.3** (composer.json).
No submodules, no Drush commands. `info.yml` sets `configure: ai_content_translator.settings`, so
the module's row on *Extend* links straight to its settings form.

## Permissions

`ai_content_translator.permissions.yml`:

| Permission | `restrict access` | Governs |
|---|---|---|
| `administer ai content translator` | `true` | The settings form (`ai_content_translator.settings`) — API endpoint, token, model, prompt, glossary. |
| `translate content with ai` | (not restricted) | Running translations: the bulk `run` form, the `node_translate` action, the per-node box, and the Translations-tab column. |

## Settings form

`SettingsForm` (`src/Form/SettingsForm.php`, `ConfigFormBase`,
`getFormId() = ai_content_translator_settings`) at route **`ai_content_translator.settings`** →
`/admin/config/regional/ai-content-translator` (menu under *Configuration → Regional and language*,
`system.admin_config_regional`). Most fields use `#config_target` to write config directly; the
**API token is handled manually** because it is stored in State, not config.

## Config object keys (`ai_content_translator.settings`)

Schema: `config/schema/ai_content_translator.schema.yml` (`config_object`). Install defaults:
`config/install/ai_content_translator.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_endpoint` | string | `https://api.openai.com/v1/chat/completions` | OpenAI-compatible chat-completions URL (`#type => url`, required). |
| `api_model` | string | `''` | Model name, e.g. `gpt-4o-mini`, `gpt-5-mini` (required). |
| `request_timeout` | integer | `120` | Guzzle request timeout (seconds). Connect timeout is a fixed 10s in code. |
| `reasoning_effort` | string | `''` | GPT-5-family param; sent only when non-empty. |
| `verbosity` | string | `''` | GPT-5-family param; sent only when non-empty. |
| `temperature` | string | `''` | Numeric string; validated numeric, cast to float, sent only when set. |
| `prompt_template` | text | professional-translator template with `@language` token (required) | Instructions; the JSON payload is appended automatically. |
| `glossary` | text | `''` | Optional JSON keyed by langcode, e.g. `{"ar": {"Term": "..."}}`; validated as JSON. |

`validateForm()` rejects a non-numeric `temperature` and invalid `glossary` JSON.

## API token — stored in State, NOT config

- Field `api_token` is a `#type => textarea` with `autocomplete => off` and an empty
  `#default_value` (the stored value is never echoed back). Its description tells the admin a token
  is already stored and to leave it blank to keep it.
- `submitForm()` writes a non-empty submitted token to
  `state->set('ai_content_translator.api_token', $token)`. It is **never** placed in the config
  object, so it does not appear in `drush cex` / config-sync.
- At request time `AiContentTranslator::requestTranslation()` reads
  `Settings::get('ai_content_translator.api_token') ?: $state->get('ai_content_translator.api_token')`
  — a `settings.php` value **takes precedence**, which is the recommended production placement:

  ```php
  // settings.php
  $settings['ai_content_translator.api_token'] = getenv('AI_CONTENT_TRANSLATOR_API_TOKEN');
  ```

## Example config export

```yaml
# ai_content_translator.settings.yml   (note: api_token is NOT here — it lives in State)
api_endpoint: 'https://api.openai.com/v1/chat/completions'
api_model: 'gpt-4o-mini'
request_timeout: 120
reasoning_effort: ''
verbosity: ''
temperature: '0.2'
prompt_template: |
  You are a professional translator.
  Translate the JSON below into @language.
  ...
glossary: '{"de": {"Dashboard": "Übersicht"}}'
```

## Target-language model

`getTargetLanguages()` returns every enabled language except the site default and locked languages
(und/zxx). There is no per-site language configuration — add languages under *Regional and
language → Languages* and they automatically become targets.

## Uninstall

`hook_uninstall()` (`ai_content_translator.install`) deletes the State token
(`ai_content_translator.api_token`) and clears the key-value collection
`ai_content_translator.machine_translations`.
