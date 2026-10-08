<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, permissions & install hooks

## Permissions (`ai_translate_textfield.permissions.yml`)

- **`use ai translation`** — editors: allows using the translate button (checked in
  `processElement()`).
- **`configure ai textfield translation`** (`restrict access: true`) — gates the settings route.

## Route & menu

`ai_translate_textfield.routing.yml`: **`ai_translate_textfield.settings_form`** →
`/admin/config/ai/ai-translate-textfield`, form `AiTranslateTextfieldSettingsForm`,
`_permission: configure ai textfield translation`, `_admin_route: TRUE`. A menu link
(`links.menu.yml`) places it under `ai.admin_settings`; a local task tab is also defined. The config
is config-translatable (`ai_translate_textfield.config_translation.yml`).

## Settings form — `AiTranslateTextfieldSettingsForm`

`src/Form/AiTranslateTextfieldSettingsForm.php` (`ConfigFormBase`, edits
`ai_translate_textfield.settings`). Uses `ai.provider` and `language_manager`.

Per **language** fieldset:
- `disabled` (checkbox) — hide the translate button for that language.
- `model` (select, required) — options from
  `AiProviderPluginManager::getSimpleProviderModelOptions('translate_text'|'chat', FALSE)`, stored as
  a `provider__model` simple string; an `#ajax` callback (`::loadModels`) reloads the fieldset.
- `prompt` (textarea) — shown only when the selected model is a **chat** model; pre-filled with a
  built-in default prompt (with prompt-injection guardrails and HTML-handling instructions). Uses
  Twig vars `{{ dest_lang_name }}` and `{{ input_text }}`.

Site-wide:
- `button_text` (textfield) — translate button label.
- `warning_enabled` (checkbox) — enable the confirm modal.
- `dialog_title` / `dialog_content` (text_format) / `dialog_ok_button` / `dialog_cancel_button` —
  the modal copy.

`submitForm()` saves all of the above into `ai_translate_textfield.settings`.

## Config schema (`config/schema/ai_translate_textfield.schema.yml`)

`ai_translate_textfield.settings` (config_object): `enabled_languages` (legacy sequence), `languages`
(sequence keyed by langcode → `{disabled: bool, model: string, prompt: string}`), `provider`
(legacy), `button_text`, `warning_enabled`, `dialog_title`, `dialog_content` (`{value, format}`),
`dialog_ok_button`, `dialog_cancel_button`. Plus
`field.widget.third_party.ai_translate_textfield` (`{strip_tags: bool, enable_translations: bool}`)
for the per-field widget settings.

`config/install/ai_translate_textfield.settings.yml` ships default button/dialog copy and a legacy
`translator_config.deepl` block (a DeepL endpoint + a placeholder key `override-this-in-a-settings-
file`). That legacy block is **not read** by the current code (translation goes through the `ai`
provider) and is cleared by `ai_translate_textfield_update_9001()`.

## Update hooks (`ai_translate_textfield.install`)

- **`_update_9001`** — removes obsolete `translation_service` from every entity form display's widget
  third-party settings, and clears `translator_config` + `strip_tags` from module config.
- **`_update_10001`** — migrates old top-level `provider`/`model` config into per-language
  `languages[$lang]['model'] = provider__model`, and converts `enabled_languages` into per-language
  `disabled` booleans.

## Post-install checklist

1. Configure per-language model/prompt at `/admin/config/ai/ai-translate-textfield`.
2. Enable the feature on chosen fields via Manage form display (see
   [../fields/widget.md](../fields/widget.md)).
3. Grant `use ai translation` to editor roles.
