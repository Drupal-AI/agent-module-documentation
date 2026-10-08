<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Replicate copies a node's Layout Builder layout into a chosen translation, including deep content.

---

Layout Replicate copies the Layout Builder layout of a node to one of its translations — including deeply nested inline blocks — so translators start from a mirror of the source layout instead of an empty one. It speeds up translating layout-built pages.

It's a Layout Builder/translation utility with no content or access role of its own; the operation follows the user's edit access. Depends on core `layout_builder`, `node`, and `block_content`; supports Drupal 10 and 11.

---

- Replicate Layout Builder layouts.
- Copy layout to a translation.
- Include deeply nested inline blocks.
- Mirror the source layout.
- Speed up translating layouts.
- Follow the user's edit access.
- Depend on core `layout_builder` and `node`.
- Depend on core `block_content`.
- Support Drupal 10 and 11.
- Avoid empty translation layouts.
- Duplicate layout structure.
- Support multilingual Layout Builder
- Copy inline blocks
- Aid translators.
- Replicate deeply.
- Handle layout translation.
- Configure the operation.
- Clone layouts across translations
