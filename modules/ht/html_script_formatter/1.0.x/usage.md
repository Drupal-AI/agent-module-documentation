<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Script Formatter outputs a text/string field's raw value as unescaped HTML.

---

HTML Script Formatter is a **field formatter that outputs the raw field value unescaped** — rendering a
text/string field's stored value directly as HTML (including `<script>`), so it can be used to embed scripts or
arbitrary markup from a field. It depends on core Field, in the Field Formatter package. It applies to `text`,
`text_long`, `text_with_summary`, `string` and `string_long` fields.

The formatter returns the field value as markup (`FormattableMarkup($item->value, [])`) and the template emits
it with **no escaping** — the module's own comment states "the user input should equal the output". It also
applies to plain **`string`/`string_long`** fields (which have **no text format**). Only apply this formatter to
fields that are editable **exclusively by fully-trusted administrators**, and prefer a real text format wherever
the value isn't guaranteed-trusted. It has no access-control role.

---

- Output the raw field value UNESCAPED.
- Render HTML/JS from a field.
- Remove output sanitization for the field.
- Apply to text/string incl. unformatted string fields.
- Depend on core Field.
- Return the value as safe markup (no escaping).
- Only use on admin-only-editable fields.
- NEVER expose such a field to authors/low-priv roles.
- Prefer a real text format (Xss::filter) otherwise.
- Have no access-control role.
- Handle the formatter.
- Output raw HTML.
- Configure with extreme caution.
- Render scripts.
- Handle the field.
- Restrict field-edit access.
- Provide a raw-HTML formatter.
