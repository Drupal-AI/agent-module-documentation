<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Readonly Html Field provides a `readonly_html_field` field type whose content is fixed per-language HTML entered in the field settings and rendered read-only on the entity's add/edit form (and on display), rather than being editable per entity.

---

Unlike normal fields, the value is not stored per entity — it is configured once in the field's *settings* form as a `text_format` (WYSIWYG) value per site language, defaulting to the `basic_html` format. The field type deliberately reports `isEmpty()` as always TRUE (so it stores nothing), and its widget/formatter simply run the configured HTML through core `check_markup()` with the chosen text format and output it as markup. The widget renders the current language's configured HTML on the entity form (falling back to the default language's text), so it behaves like an inline, translatable instructional note or terms-of-service block shown to content editors or, on registration/other forms, to end users. The module has no routes, permissions, services, or configuration page — you add and configure the field through Field UI like any other field.

Typical use cases are webmaster notes on node add/edit forms and terms-of-service text on the account registration form. Security posture is sound: the configured HTML is always passed through `check_markup()` with a text format, so output is filtered per the selected format rather than printed raw; because the format is chosen by whoever configures the field (a Field-UI-privileged user), pick a restricted format like `basic_html` for content authored by less-trusted roles.

---
- Add a webmaster note to a node add/edit form.
- Show terms-of-service text on the user registration form.
- Display fixed instructions to editors above other fields.
- Add a translatable help block that varies by language.
- Render rich HTML (headings, links, lists) read-only on a form.
- Provide legal/disclaimer text on a content form.
- Show guidance without adding an editable/stored value.
- Choose the text format (e.g. basic_html) for the note.
- Configure different note text per site language.
- Fall back to default-language text when a translation is missing.
- Display the same read-only HTML on the entity's rendered view.
- Add contextual help to a specific content type only.
- Warn editors about a workflow step directly on the form.
- Embed a styled callout box in an add/edit form.
- Add onboarding instructions to a custom entity form.
- Provide field-group-level guidance without a module like Field Group.
- Show a "please review before publishing" reminder on forms.
- Present contributor guidelines on a comment or node form.
- Add a read-only announcement to editors during a migration.
- Reuse the note across bundles by adding the field to each.
