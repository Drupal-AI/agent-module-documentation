<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The per-field translate button (widget integration)

## Install & enable

```bash
composer require drupal/ai_translate_textfield
drush en ai_translate_textfield -y
```

Requires the Drupal **AI** module (`ai`) and at least one provider that implements `translate_text`
(e.g. DeepL provider) or `chat` (e.g. OpenAI). Then:

1. Configure per-language model/prompt at `/admin/config/ai/ai-translate-textfield` (see
   [../config/settings.md](../config/settings.md)).
2. On **Manage form display** for a bundle, edit a supported text widget's settings and tick
   **"Enable textfield translation feature on this field."** (optionally "Remove possible HTML
   formatting … before translation").
3. Grant the **`use ai translation`** permission to editor roles.

## Supported widgets

`AiTranslateTextfieldCallbacks::SUPPORTED_FIELD_WIDGETS`: `string_textarea`, `text_textarea`,
`string_textfield`, `text_textfield`, `text_textarea_with_summary`.

## Wiring (`ai_translate_textfield.module`)

- `hook_field_widget_third_party_settings_form` adds two per-field third-party settings under
  namespace `ai_translate_textfield`: `enable_translations` (checkbox) and `strip_tags` (checkbox).
- `hook_field_widget_settings_summary_alter` appends "AI Textfield Translation enabled/disabled" to
  the widget summary.
- `hook_field_widget_single_element_form_alter` calls
  `AiTranslateTextfieldCallbacks::processElement()`.

## `processElement(&$element, $form_state, $context)`

Returns early unless the widget is supported, `enable_translations` is on, **and**
`\Drupal::currentUser()->hasPermission('use ai translation')`. It also returns early if the entity's
language is marked `disabled` in `ai_translate_textfield.settings`.

When active it wraps the element in a `<div class="{id}">` and adds a `translate_button`
(`#type => button`) with an `#ajax` callback to `ajaxTranslateText`, `#limit_validation_errors => []`,
and `#widget_settings` carrying `strip_tags` and an `html` flag (true for `text_*` field types). If
`warning_enabled` is set, it also attaches the `modal-button-action` library + `drupalSettings` and
adds a visible `translation_warning_button` that (via JS) shows a confirm dialog before clicking the
now-hidden real translate button.

## `ajaxTranslateText(&$form, $formState)` — the translate action

This is a **Form API AJAX callback** (a trusted callback), not a standalone route, so it inherits the
edit form's CSRF form-token protection and only runs when the button (which is gated by permission +
form access above) is present.

1. Reads the triggering element, its `#widget_settings`, and the current field value
   (`$formState->getValue([...,'value'])`).
2. Target language = `$formState->getFormObject()->getEntity()->language()->getId()`.
3. Calls `translateText($fieldValue, $widgetSettings, $target_language)`.
4. Builds a `status_messages` render array. On success it also shows the **original** text back
   ("…The original text was:" + `<br>` + `$fieldValue`).
5. Only on success (non-empty translation that differs from the source) does it write the translation
   into `$formState` and the widget's `#value`; otherwise the field is left unchanged with an error
   message. Returns an `AjaxResponse` with a `ReplaceCommand` on the wrapper.

## `translateText($text, $settings, $targetLang)` (protected)

- Reads `ai_translate_textfield.settings` `languages[$targetLang]`; throws (editor-facing message) if
  no config, no model, or the language is `disabled`.
- If `strip_tags` is set, strips HTML via `Soundasleep\Html2Text::convert()` when available, else
  `strip_tags()`.
- Resolves the provider from the stored `provider__model` string via `ai.provider`
  (`getProvider()`).
- If the provider supports **`translate_text`**: wraps text in `TranslateTextInput` and calls
  `translateText()`; for the DeepL provider with an HTML field it sets `tag_handling => 'html'`.
- Else if it supports **`chat`**: requires a per-language `prompt`, renders it with
  `twig->renderInline($prompt, ['dest_lang', 'dest_lang_name', 'input_text' => $text])` (the source
  text is passed as the bound Twig variable `input_text`), sends a system+user
  `ChatInput`, trims code fences/quotes from the reply, and — using `HtmlDetector` — decodes HTML
  entities back if the model escaped them.
- Returns the translated string. `GuzzleException`/errors surface as an editor message.

## Rendering / safety notes

- The translated value goes into a form field value (escaped by Form API on output) and, when saved,
  is rendered through the field's normal text format — an editor can already type the same content
  into the field directly.
- The "original text" echoed in the success status message is the editor's own field input, rendered
  through the status-messages theme.
