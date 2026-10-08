<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode — agent index

WP-style `[tag]...[/tag]` filter framework. Defines a `shortcode` **plugin type** (annotation
`@Shortcode`, discovered from `Plugin/Shortcode/`, managed by `plugin.manager.shortcode`) and a
text-format **filter** (`id: shortcode`) that expands enabled tags into HTML. Ships **no tags
itself** — `shortcode_basic_tags` and `shortcode_example` (or your own module) supply them.
No configure route (`configure: null`), no permissions, no Drush.

- **Write a Shortcode plugin** (annotation fields, `ShortcodeBase`, `process()`/`tips()`) →
  [plugins/shortcode-plugin.md](plugins/shortcode-plugin.md)
- **Enable the `shortcode` filter on a text format, toggle individual tags** →
  [configure/enable-filter.md](configure/enable-filter.md)
- **Call the `shortcode` service / `ShortcodePluginManager` programmatically** →
  [api/service.md](api/service.md)

Key facts:
- Plugin **id** identifies the plugin internally; the **token** (defaults to id, lowercased) is
  what's actually matched in `[token ...]` markup — a plugin can expose a different token than
  its id.
- Per-format enablement lives at `filter.format.<format>.filters.shortcode.settings`, a map of
  shortcode-id → boolean (schema `filter_settings.shortcode`, a sequence of booleans keyed by id).
- A second filter, `shortcode_text_corrector` (id `shortcode_corrector`), cleans up `<p>`/`<div>`
  wrapping WYSIWYG editors add around block-level shortcode tags — enable it alongside `shortcode`
  when editors use CKEditor.
