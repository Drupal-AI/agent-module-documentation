<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object and permission

## Install & enable

```bash
composer require drupal/ai_content_translation
drush en ai_content_translation -y
```

Core dependencies: **`content_translation`** and **`config`** (from `ai_content_translation.info.yml`).
No composer requirements, no submodules, no Drush commands. `hook_install()`
(`ai_content_translation.install`) seeds the config object with defaults and grants the module
permission to the `administrator` role.

## Permission

`ai_content_translation.permissions.yml` declares one permission:

| Permission | `restrict access` | Governs |
|---|---|---|
| `administer ai content translation` | `true` | The settings form **and** the translate action (both routes require it). |

There is no separate "translate content" permission — the same admin permission both configures
the module and triggers translations.

## Settings form

`AIContentTranslationSettingsForm` (`src/Form/AIContentTranslationSettingsForm.php`,
`getFormId() = ai_content_translation_settings`) is a `ConfigFormBase` at route
**`ai_content_translation.settings`** → `/admin/config/content/ai-content-translation`
(`_permission: administer ai content translation`). Menu link `ai_content_translation.settings`
places it under *Configuration → Content authoring* (`system.admin_config_content`, weight 100).

It edits exactly one config object, **`ai_content_translation.settings`**.

## Config object keys

Schema: `config/schema/ai_content_translation.schema.yml` (type `config_object`). Defaults come
from `hook_install()` and from the form's `?:` fallbacks.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | (empty) | OpenAI API key. **Required** on the form; stored as plain config text. |
| `model` | string | `gpt-4` | Select: `gpt-4`, `gpt-4-turbo`, `gpt-3.5-turbo`. |
| `system_prompt` | text | professional-translator prompt | Instruction prepended to every request; the service appends `Translate it to <language>.` |
| `temperature` | float | `0.3` | Sampling temperature (0–2), cast to float for the request. |
| `timeout` | integer | `180` | Guzzle request timeout in seconds (form range 30–600). |
| `connect_timeout` | integer | `60` | Guzzle connect timeout in seconds (form range 5–600). |
| `enable_logging` | boolean | `TRUE` | Master switch for non-error logging. |
| `log_level` | string | `notice` | `error` / `notice` / `info` — how much the module logs. |
| `show_sample_text` | boolean | `TRUE` | Include source/translated text snippets (first 100 chars) in logs. |

`submitForm()` writes all nine keys back to the config object. Note the install default
`system_prompt` omits the "including all the HTML tags" clause that the form's fallback default
adds — the effective prompt depends on whether the admin saves the form.

### Example config export

```yaml
# ai_content_translation.settings.yml
api_key: 'sk-...'
model: gpt-4
system_prompt: 'You are a professional translator. ... Provide only the translated text without explanations.'
temperature: 0.3
timeout: 180
connect_timeout: 60
enable_logging: true
log_level: notice
show_sample_text: true
```

## Logging behaviour

Both `AITranslationController::log()` and `OpenAITranslationService::log()` implement the same
gate: `error` is always logged to the `ai_content_translation` channel; other levels are dropped
when `enable_logging` is FALSE, and otherwise filtered by `log_level` (`notice` logs notices;
`info` logs everything). When `show_sample_text` is on, the service logs the first 100 characters
of source and translated text — disable it if content is sensitive, since those snippets otherwise
land in dblog.

## Uninstall

`hook_uninstall()` deletes the `ai_content_translation.settings` config object (including the
stored `api_key`).
