<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Textfield Translation adds a per-field "Request automatic translation" button to text field widgets on entity edit forms, filling the field with an AI translation via the Drupal AI module.

---

AI Textfield Translation extends Drupal's text/string field **widgets** so a content editor can, from
the entity edit form, translate a single field's value into the entity's language with one button.
It supports any translator that implements the Drupal AI module's `translate_text` operation (e.g.
DeepL via a provider module) and also works with `chat` providers (e.g. OpenAI) using a configurable
prompt. The feature is turned on **per field** in the form-mode (Manage form display) third-party
settings, and only shown to users holding the `use ai translation` permission. An optional warning
modal makes editors acknowledge that machine translation must be reviewed before saving — the module
is explicitly designed to assist, not replace, human review. Site-wide options (per-language model
and prompt, button text, and the warning dialog copy) live in `ai_translate_textfield.settings`. The
translate action runs as a Form API AJAX callback on the edit form; the field text is sent to the
configured AI provider.

Use it to:

- Let editors translate one text field at a time from the edit form.
- Add AI translation without changing the site's translation workflow.
- Support DeepL (via `translate_text` operation) translator providers.
- Support chat AI providers (e.g. OpenAI) with a custom translation prompt.
- Enable the feature only on selected fields via Manage form display.
- Restrict who can translate with the `use ai translation` permission.
- Show a warning modal that editors must accept before translating.
- Pick a different AI model per target language.
- Customize the translate button label.
- Strip HTML before translation on a per-field basis.
- Preserve HTML markup when a provider supports HTML tag handling.
- Keep the original text visible in a status message after translating.
- Only replace the field value when a non-empty, changed translation returns.
- Translate `string_textfield`, `string_textarea`, `text_textfield`, `text_textarea` and
  `text_textarea_with_summary` widgets.
- Translate the pre-configured UI copy of the module itself (config translation).
- Remind editors that third-party machine output needs review.
- Help multilingual teams speed up first-pass translations.
- Work on any content entity type that has text fields.
