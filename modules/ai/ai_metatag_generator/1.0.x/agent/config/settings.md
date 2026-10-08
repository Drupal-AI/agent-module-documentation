<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config keys & prompts

## Install / enable

Requires the **AI module** (`drupal/ai`) with a chat provider and the **Metatag module**
(`drupal/metatag`), plus PHP 8+. `drush en ai_metatag_generator`. Ships default config
(`config/install/ai_metatag_generator.settings.yml`) and a schema
(`config/schema/ai_metatag_generator.schema.yml`). The target content types need a Metatag field
whose machine name you record in `metatag_field`.

## Permissions (`ai_metatag_generator.permissions.yml`)

- **`administer ai metatag generator`** (`restrict access: true`) — configure the module.
- **`use ai metatag generator`** — see and use the generate button on node edit forms.

## Settings form

Route `ai_metatag_generator.settings` → `/admin/config/ai/ai-metatag-generator`, permission
`administer ai metatag generator`. Form `Form\AiMetatagConfigForm` (id
`ai_metatag_generator_settings`), config object `ai_metatag_generator.settings`. If no
chat-capable AI provider exists, the form shows a notice and stops.

| Key | Widget | Meaning |
|---|---|---|
| `content_types` | checkboxes | Content types where the button appears. |
| `metatag_field` | textfield | Machine name of the Metatag field (e.g. `field_meta_tag`). |
| `provider_model` | select | AI simple-option provider/model; empty = default `chat` provider. |
| `strip_html` | checkbox (default TRUE) | Strip HTML from rendered content before sending. |
| `display_mode` | textfield (default `full`) | View mode used to render the node. |
| `black_list` | textarea | Words/phrases removed from the content (one per line, word-boundary regex). |
| `prompts` | per-language textareas (`#tree`) | Prompt override per site language (`prompts.<langcode>.prompt`). |
| `success_messages` | per-language textareas | Success-dialog text override per language. |
| `error_messages` | per-language textareas | Error-dialog text override per language. |

A read-only **Default Prompt** textarea shows `AiMetatagService::getDefaultPrompt('<Current
Language>')` for reference; it is not saved. `submitForm()` writes each value and `array_filter()`s
the message maps.

## Prompt resolution (`AiMetatagService::callAiService()`)

For the current language it reads `prompts.<current_langcode>.prompt`, then
`prompts.<default_langcode>.prompt`, then falls back to `getDefaultPrompt(currentLanguageName)`.
The chosen prompt becomes the **system prompt**, and the module appends a fixed instruction to
return JSON `{"description":..., "abstract":..., "keywords":...}`. The default prompt asks for a
≤160-char description, a ≤160-char abstract, and ≤10 comma-separated keywords in the current
language.

## Config schema

`config/schema/ai_metatag_generator.schema.yml` types `content_types` (sequence),
`metatag_field`/`provider_model`/`display_mode` (string), `strip_html` (boolean), `black_list`
(text), `prompts` (mapping of langcode → `{prompt}`), and `success_messages`/`error_messages`
(langcode → string). So `provides_config_schema` is true.
