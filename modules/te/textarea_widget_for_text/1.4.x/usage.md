<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Textarea Widget For Text Fields lets ordinary short ("non-long") text fields use core's multi-row **Text area** widget on entity edit forms, instead of being limited to a single-line textfield.

---

The module is a single `hook_field_widget_info_alter()` implementation. Core normally offers the multi-line textarea widgets only to the "long" text types, so a plain `string` field or a single-line `text` (formatted) field can only use a one-line input. This module adds the `text` field type to core's `text_textarea` widget's allowed `field_types`, and the `string` field type to core's `string_textarea` widget — nothing more. After enabling it you simply go to *Manage form display* for the bundle and switch the field's widget from "Textfield" to **"Text area (multiple rows)"**. There is no settings form, no configuration object, no permission, no Drush, and no plugin: the only persistent effect is the widget `type` recorded on that field's component in the `entity_form_display` config (`string_textarea` or `text_textarea`). The module's own help text notes you could achieve the same with a two-line custom `hook_field_widget_info_alter()`; the module just packages it. Works anywhere fields are configured (content types, users, comments, taxonomy terms, media, etc.).

---

- Give a short "Summary" or "Subtitle" text field a multi-row textarea for easier editing.
- Let editors enter several lines into a plain `string` field (e.g. an address block).
- Use a textarea for a single-line `text` (formatted) field without switching to a long-text field.
- Provide roomier input for a "SEO description" short text field.
- Turn a taxonomy term's short text field into a multi-line textarea.
- Use a textarea widget on a user-profile short text field.
- Allow line breaks in a short text field's editing UI (storage still short text).
- Avoid creating a "Text (formatted, long)" field just to get a textarea.
- Standardise multi-line entry for short text fields across a content type.
- Configure per form mode: textarea on the default form, textfield elsewhere.
- Give comment short text fields a textarea widget.
- Make a media entity's short text field use a textarea.
- Provide a bigger input box for a "tagline" or "excerpt" short text field.
- Keep a 255-character limit while still offering a multi-row editing box.
- Replace a cramped one-line input for notes/remarks fields.
- Apply the textarea widget to a `string` field created by another module.
- Improve editorial UX for fields that logically hold a few lines but are stored short.
- Export the choice in config (widget type `string_textarea`/`text_textarea` in the form display).
- Roll multi-line editing out to short text fields site-wide by re-selecting their widget.
- Drop the module later by reverting the field's widget to the default textfield.
