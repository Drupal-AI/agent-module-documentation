<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File attributes extends the core File field type so editors can attach arbitrary HTML anchor attributes (such as `target`, `rel`, `download`, or CSS classes) to file download links. It provides a field type override, a widget for entering attributes, and a formatter that renders the link with those attributes applied.

---

- Drupal 9.3+ or 10; no extra module dependencies (core file/field).
- Enable with `drush en file_attributes`.
- The module alters the core `file` field type to add an `options` (attributes) property.
- On a file field's "Manage form display", use the File attributes widget to enter attributes per file item.
- On "Manage display", choose the "File attributes" formatter to render links with the stored attributes.

---

- Add `target="_blank"` to file download links.
- Add `rel="nofollow"`/`rel="noopener"` to file links.
- Add the HTML5 `download` attribute to force downloads.
- Attach custom CSS classes to file links.
- Set per-file-item attribute values via the widget.
- Render file links with microformat type/length attributes.
- Use the file description as link text when present.
- Keep MIME-based CSS icon classes on links.
- Apply attributes without a custom theme/template.
- Extend the core File field non-destructively.
- Support single and multi-value file fields.
- Generate absolute file URLs for the link.
- Improve accessibility/UX of download links.
- Control link behavior per content item.
- Work with existing file uploads (no re-upload).
- Provide a formatter alternative to the generic file formatter.
