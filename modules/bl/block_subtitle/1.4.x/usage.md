<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Subtitle adds a second line of text to a block's configuration — a strapline under the block title — without needing a custom block type or a template override per block.

---

Design comps routinely put a heading and a supporting line above a block's content: "Latest news" with "Updates from across the organisation" beneath it. Drupal's block has one title, so the usual implementations are a custom block content type with a subtitle field (heavy for a system block or a view block, which have no fields), or markup smuggled into the title (which then appears in the admin listing and anywhere the title is used as text). This module adds the subtitle as a **block configuration** value instead, so it works on any block plugin — system blocks, views blocks, menu blocks — and exports with the block's configuration. The module is small: a `.module` file, `config/schema` for the setting, and a permission, `administer block subtitle`, which usefully separates "may set a subtitle" from full block administration. Core range is wide, `^8 || ^9 || ^10 || ^11`, and the only dependency is core `block`. Themers should note the subtitle is available in the block template, so its markup and placement remain a theme decision.

---

- Add a strapline under a block title.
- Give a views block a supporting line.
- Match a design comp's block heading pattern.
- Avoid a custom block type for one extra line.
- Add a subtitle to a system block.
- Keep the subtitle out of the admin block listing.
- Export subtitles with block configuration.
- Style the subtitle from the block template.
- Give a menu block a description line.
- Delegate subtitle editing by permission.
- Add context to a sidebar block.
- Support a marketing page's heading structure.
- Keep block titles clean for accessibility.
- Add a subtitle without a template override.
- Apply subtitles across many block types.
- Provide bilingual heading pairs.
- Improve scanability of a landing page.
- Support a site still on Drupal 8.
