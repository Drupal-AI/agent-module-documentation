<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dublin Core elements this submodule registers

All 15 elements are **item** elements (no channel elements), namespace `dc` (URI
`http://purl.org/dc/elements/1.1/`), module key `views_rss_dc`. Config path in
`views.view.<name>`: `display.<id>.display_options.row.options.item.dc.views_rss_dc.<name>`,
value = a View field machine name.

| Element | Notes |
|---|---|
| `dc:title` | Plain text pass-through. |
| `dc:creator` | **Preprocessed**: strips a leading `"   Author"` marker and any `Role...` suffix from each comma-separated name, keeping only the trimmed author name(s) — one `<dc:creator>` per name. |
| `dc:subject` | Plain text pass-through (recommended: controlled vocabulary/keywords). |
| `dc:description` | Runs `views_rss_rewrite_relative_paths()` — relative image/link paths become absolute. |
| `dc:publisher`, `dc:contributor` | Plain text pass-through. |
| `dc:date` | **Preprocessed** in two steps: first `views_rss_core_preprocess_item_pubdate()` (strips stray `<time>` wrapper tags), then reformatted with `date('c', strtotime(...))` — **ISO-8601**, not the RFC-822 format `views_rss_core`'s `pubDate`/`lastBuildDate` use. |
| `dc:type`, `dc:format`, `dc:identifier`, `dc:source`, `dc:language`, `dc:relation`, `dc:coverage`, `dc:rights` | Plain text pass-through; each carries only descriptive help text pointing at the Dublin Core spec. |

None of these are `configurable: FALSE`, so all 15 always appear as selectable dropdowns in the
row plugin's "Item elements : dc" fieldset once this module is enabled — leaving one at
`- None -` simply omits that tag from the feed (no empty tags are emitted).

See the parent's [hooks/element-hooks.md](../../../../../2.4.x/agent/hooks/element-hooks.md)
for what `preprocess functions` / `configurable` mean generically.
