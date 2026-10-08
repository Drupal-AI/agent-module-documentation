<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filelist formatter displays the values of a core file field as an HTML list (ul/ol), optionally appending each file's size.

---

It adds a formatter (id `filelist_formatter`, label "List") for `file` fields, extending core's
`FileFormatterBase`. Instead of core's default file table/links, each displayed file becomes a
`#theme => file_link` item wrapped in an `item_list`, letting you present attachments as a clean bulleted
or numbered list. It respects the field's *display* flag and description handling: it uses the file's
description when the field has `description_field` enabled, otherwise the filename; when the *Show filesize*
option is on it appends the human-readable size via `ByteSizeMarkup` (the Drupal 11 replacement for
`format_size()`).

Configure it per display on **Manage display**. Three settings: *List type* (`ul` unordered or `ol`
ordered), *List classes* (CSS classes added to the list — escaped with `Html::escape` in the summary), and
*Show filesize* (checkbox). It is purely a display formatter — no routes, permissions, services or state —
so it carries no access surface of its own; file access remains governed by core File. Drupal 11 only.

---

- Render a multi-value file field as a bulleted list.
- Render file attachments as a numbered (ordered) list instead.
- Show each file's size next to its link.
- Add custom CSS classes to the generated list.
- Use the file description as the link text when available.
- Fall back to the filename when no description is set.
- Present downloads more compactly than the default file table.
- Apply to any core file field on any entity display.
- Toggle filesize display per view mode.
- Keep core file-link theming and cache tags.
- Style attachment lists via the class setting + theme CSS.
- Respect each item's display checkbox.
- Show a human-readable size via ByteSizeMarkup.
- Choose ul vs ol per display mode.
- Provide a teaser-friendly file list on listings.
- Use with no configuration beyond picking the formatter.
