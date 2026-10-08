<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toc.js Filter — agent index

Submodule of Toc.js. Adds a text-format **filter** `toc_js_filter` that replaces `[toc]` in text
with a Toc.js table of contents. Requires `toc_js`. No settings page, no `configure` route, no
permissions, no Drush. Config schema: `filter_settings.toc_js_filter`.

- **The `[toc]` filter plugin, its settings, and enabling it on a text format** →
  [plugins/filter.md](plugins/filter.md)

Key facts: filter plugin id `toc_js_filter` (title "TOC.js shortcode: [toc]"). Enable it on a text
format (`filter.format.<id>` → `filters.toc_js_filter.status: true`); its settings mirror the Toc.js
block settings (via `TocJsService::getTocForm()`) and the TOC is still built client-side.
