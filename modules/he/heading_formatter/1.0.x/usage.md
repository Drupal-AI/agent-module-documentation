<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Heading formatter is a field formatter that outputs a plain-text (string/textfield) field as an HTML heading with an optional CSS class.

The `heading` formatter plugin applies to `string` and `textfield` field types. On Manage Display an editor picks the tag (h1, h2 or h3) and enters a class string; at render time each field value is emitted through a core `html_tag` render element using the chosen tag and class. It is a tiny display-only helper with no configuration outside the formatter settings, no routes, services or permissions.

Typical setup: on a content type's Manage Display, set the target string field's formatter to "Heading", choose the level and class, and save.
---
Heading formatter renders a plain-text string field as an h1/h2/h3 heading with a custom CSS class.
---
- Set a string field's formatter to "Heading" on Manage Display.
- Choose the heading level H1.
- Choose the heading level H2.
- Choose the heading level H3.
- Add a custom CSS class to the heading.
- Style a node title-like field as a page heading.
- Render a subtitle field as an H3.
- Apply utility classes for spacing or color to the heading.
- Use different heading levels per view mode.
- Keep headings consistent across content types via a shared class.
- Display a taxonomy term name field as a heading.
- Emphasize a short summary field as an H2.
- Combine with other formatters on multi-value fields.
- Configure the formatter per display mode (teaser vs. full).
- Reuse the class to hook theme CSS onto headings.
- Avoid manual markup in the field for simple headings.
- Preview the result on the entity's display.
- Remove the formatter by switching back to the default text formatter.
- Document the class convention for content editors.
