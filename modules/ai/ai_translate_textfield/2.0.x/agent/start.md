<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Textfield Translation (ai_translate_textfield) — agent index

Adds a per-field **"Request automatic translation"** button to text/string field **widgets** on
entity edit forms; the AJAX callback fills the field with an AI translation via the **Drupal AI**
module. Version **2.0.0-alpha2**. Core `^10 || ^11`, PHP `^8.1`. License GPL-2.0-or-later. Package
`Content`. Configure at `ai_translate_textfield.settings_form`.

Dependency: `ai:ai` (>=1.0.0-beta1). Composer requires `drupal/ai:^1.0@beta`.

## What it provides

- **Widget integration via hooks** (`ai_translate_textfield.module`):
  `hook_field_widget_third_party_settings_form` (per-field enable + strip-tags toggles),
  `hook_field_widget_settings_summary_alter`, and
  `hook_field_widget_single_element_form_alter` → `AiTranslateTextfieldCallbacks::processElement()`.
- **`AiTranslateTextfieldCallbacks`** (`src/AiTranslateTextfieldCallbacks.php`, implements
  `TrustedCallbackInterface`) — builds the button(s) and the `ajaxTranslateText` AJAX callback that
  translates the current field value and replaces it. Supported widgets: `string_textarea`,
  `text_textarea`, `string_textfield`, `text_textfield`, `text_textarea_with_summary`. →
  [fields/widget.md](fields/widget.md)
- **`HtmlDetector`** (`src/Utility/HtmlDetector.php`) — `containsHtml()` / `containsHtmlEntities()`
  helpers used to fix up entity-escaped chat output.
- **Settings form** `AiTranslateTextfieldSettingsForm` (`ConfigFormBase`) — per-language model +
  prompt, button text, and warning-modal copy. → [config/settings.md](config/settings.md)
- **JS** `js/modal-button-action.js` (library `modal-button-action`) — optional confirm dialog
  before triggering the hidden translate button.
- **Permissions** (`ai_translate_textfield.permissions.yml`): `use ai translation` (editors) and
  `configure ai textfield translation` (`restrict access: true`, gates the settings form).
- **Config** `ai_translate_textfield.settings` (schema + `config/install`, config-translatable).
  Update hooks in `.install` migrate old `provider`/`model`/`translator_config` config.

## Route

`ai_translate_textfield.settings_form` → `/admin/config/ai/ai-translate-textfield`, form
`AiTranslateTextfieldSettingsForm`, `_permission: configure ai textfield translation`, `_admin_route`.
The translate action itself has **no dedicated route** — it is a Form API `#ajax` callback on the
entity edit form (CSRF-protected by the form token), only rendered for users with `use ai
translation`. Field text is sent to the configured AI provider.
