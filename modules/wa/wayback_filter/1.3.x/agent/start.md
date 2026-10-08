<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wayback Filter (wayback_filter) — agent index

**Text-format filter + link-field preprocessor that adds Internet Archive Wayback Machine links to links in nodes older than a configured age.**

- **Version:** 1.3.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Dependencies:** system, link
- **Configure:** `wayback_filter.settings` → `/admin/config/content/wayback_filter` (perm `administer site configuration`)
- **Filter plugin:** `wayback_filter` (`src/Plugin/Filter/wayback_filter.php`), modes `append`/`replace`
- **Also:** `hook_preprocess_node` handles configured link fields (experimental) via `Url::fromUri()`
- **Settings:** `waybacklink_mode`, `waybacklink_icon`, `waybacklink_title`, `waybacklink_start` (years), `field_link[]`

**Security:** **No SSRF** — the filter never fetches a URL server-side; it only string-builds `web.archive.org/web/<time>/<url>` from links already in the content. Node-age lookup binds `nid` via `->condition('nid', $arg[1])` (parameterized). XSS risk low: href regex `href="([^"]*)"` cannot capture a quote, and icon/title come from admin config (settings form gated by `administer site configuration`); output returned as `FilterProcessResult`. Place the filter late in the format's filter order.

See [configure/filter.md](configure/filter.md)
