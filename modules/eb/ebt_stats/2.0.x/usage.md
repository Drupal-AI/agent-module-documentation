<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Drupal block content type for displaying a row of statistics (big numbers with text/icons) in Layout Builder or the block layout.

---

Extra Block Types (EBT): Stats adds an "EBT Stats" block content type to the Extra Block Types family. Each block holds an optional WYSIWYG body plus a repeatable set of "EBT Stats Item" paragraphs, where every item carries a large number, descriptive text, an optional link and an optional image/icon (Media). A custom settings widget (`ebt_settings_stats`, extending EBT Core's default) lets the editor pick one of three predefined presentation styles — "stats with vertical dividers", "stats in squares", or "stats in a column" — and the matching CSS library is attached automatically at render time. The module ships only entity configuration, templates and CSS; it defines no routes, permissions, services or Drush commands, and relies on EBT Core for the shared `ebt_settings` field type/design options and on Paragraphs for the repeatable items.

---

- Show a "trusted by" or "by the numbers" strip on a landing page (e.g. 10k+ users, 99.9% uptime, 24/7 support).
- Display company KPIs (revenue, customers, projects delivered) as large highlighted numbers with captions.
- Build an "our impact" section for a nonprofit (people helped, funds raised, volunteers).
- Present product statistics (downloads, integrations, countries served) in a Layout Builder section.
- Add a stats banner to a homepage hero area using the "stats in squares" layout.
- Render team or event metrics with the "vertical dividers" style for a compact single-row look.
- Stack statistics vertically on narrow content regions or sidebars using the "stats in column" style.
- Attach an icon (Media image) to each statistic, such as a small badge next to each number.
- Link individual statistics to detail pages or reports via the per-item link field.
- Add an introductory heading and rich-text description above the numbers via the block body field.
- Reuse the same stats block across multiple pages by placing the reusable block content in Block layout.
- Create one-off inline stats blocks directly inside a Layout Builder layout (inline block usage).
- Combine with other EBT blocks (Hero, Columns, Counter) to compose a full marketing page without custom code.
- Apply EBT Core design options (margins, padding, borders, background color/image, container width) per block.
- Provide translatable statistics blocks on multilingual sites (body and settings fields are translatable).
- Add or reorder statistics after launch by editing the paragraph items — no code changes needed.
- Give content editors a repeatable, drag-and-drop way to manage a metrics section.
- Standardize the look of statistics sections site-wide by using the shipped presentation styles.
- Swap the presentation style of an existing block without re-entering data, just by changing the Styles radio.
- Extend the shipped CSS (via a subtheme) to match brand colors while keeping the module's markup structure.
