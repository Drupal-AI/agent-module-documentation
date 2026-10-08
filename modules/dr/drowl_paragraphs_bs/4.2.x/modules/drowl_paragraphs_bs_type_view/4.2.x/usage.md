<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'View' Paragraph bundle that embeds a Drupal View into content.

---

This sub-module installs the `view` Paragraph type with a `viewsreference` field (`field_view`) so editors can drop a Drupal View into Paragraphs-based content. The viewsreference formatter renders the selected view display; the view runs its own access plugin at render time, so an embedded view is shown according to that view's access rules for the current viewer. Editors may optionally pass a contextual argument and set a title (enabled viewsreference settings: argument, title).

---

- Embed any Drupal View display (default/page/block/attachment/feed) into content.
- Pass a contextual filter argument to the embedded view.
- Override the view title for the embed.
- Reuse existing site Views inside page-built content without code.
- Combine with field_settings for animation/classes/id on the wrapper.
- Let the embedded view's own access plugin decide visibility per viewer.
- Enable only when editors need to place Views into Paragraphs.
