<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Specific Class — agent index

Adds CSS classes to the `<body>` tag per page via one admin setting. Implemented as a single
`hook_preprocess_html()`. No plugins, no own permissions, no Drush.

- **Configure per-page/wildcard/front/all-page body classes; config key & matching rules** →
  [configure/body-classes.md](configure/body-classes.md)

Key facts:
- Config object `page_specific_class.settings`, single key **`url_with_class`** — a multi-line
  string, one `/<path>|<class(es)>` mapping per line.
- Admin form: route `page_specific_class.settings` → `/admin/config/page-class/settings`,
  permission `administer site configuration`.
- Special targets: `/<front>` (front page), `/*` (every page), `/prefix*` (wildcard prefix).
