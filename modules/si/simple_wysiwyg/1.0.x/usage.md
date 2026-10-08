<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a minimal JavaScript rich-text toolbar to plain string/text field widgets, with bold/italic/underline/strike/super/subscript and a source view.

---

The module supplies a Field widget (`simple_wysiwyg`) and a Field formatter (`simple_wysiwyg`) for `string`, `string_long`, `text` and `text_long` fields. The widget renders a normal textfield/textarea, attaches its library and passes per-instance JS settings (visible buttons, an `allowed_tags` string, multiline flag and max length) via a `data-simple-wysiwyg-settings` attribute; the accompanying JavaScript then decorates it with a contenteditable toolbar. The formatter outputs the stored value.

Setup: on a field's *Manage form display* choose the Simple WYSIWYG widget and configure buttons/allowed tags; on *Manage display* choose the Simple WYSIWYG formatter.

---
- Add a light rich-text editor to a plain text field without CKEditor.
- Enable bold/italic/underline formatting on a short text field.
- Offer strikethrough, superscript and subscript buttons.
- Provide a source-code toggle in the editor.
- Restrict the toolbar to a chosen subset of buttons.
- Configure the client-side allowed-tags list for a field.
- Enable single-line mode by disabling multiline input.
- Enforce a maximum length on the edited value.
- Format string, string_long, text and text_long fields.
- Render stored markup with the Simple WYSIWYG formatter.
- Give editors basic formatting on a node title-like field.
- Keep the editor dependency-free (core/drupal + core/once only).
- Apply the widget from Manage form display per field instance.
- Summarise widget settings on the field display overview.
- Add lightweight formatting to a promo/teaser text field.
- Let content editors add emphasis without a full editor toolbar.
- Configure a distinct button set per field instance.
- Keep field storage as plain text while offering formatting.
