<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Class Demo (bundle_class_demo) — agent index

A demonstration **Olivero sub-theme** shipped inside the `bundle_classes` project
(`themes/bundle_class_demo/`). It exists only to show a bundle-class method being called from a
template. Version **1.0.0-alpha2**. Core `^10.5 || ^11.2 || ^12`. License GPL-2.0-or-later.

- **`bundle_class_demo.info.yml`** — `type: theme`, `base theme: olivero`, description "A theme with
  templates demonstrating usage of bundle classes." Re-declares Olivero's standard regions (header,
  primary_menu, hero, content, sidebar, footer_top/bottom, etc.). No libraries, no dependencies
  beyond the base theme.
- **`templates/node/node--article.html.twig`** — a copy of Olivero's node template. Inside the node
  content `<div>`, between `<!-- Bundle class demo inclusion -->` comments, it prints
  `{{ node.getLastUpdatedDate }}` — the method added by the parent module's `Article` bundle class.
- **`logo.svg`** — theme logo asset only.

## How to use

1. Enable the parent module: `drush en bundle_classes` (pulls `bca`).
2. Enable + apply the theme: `drush theme:enable bundle_class_demo`, then set it as the default (or
   admin) theme at `/admin/appearance`.
3. Create/edit an Article node; the formatted "Last updated" date rendered by
   `Article::getLastUpdatedDate()` appears in the node content.

## Notes

- Purely presentational/teaching; no PHP, no config, no permissions, no routes.
- The template relies on Twig's entity-method access (only `get*`/`has*`/`is*` and a few whitelisted
  methods are callable), which is why the method is named `getLastUpdatedDate`.
- Parent module + the bundle class it depends on:
  [../../../../agent/start.md](../../../../agent/start.md) and
  [../../../../agent/api/bundle-class.md](../../../../agent/api/bundle-class.md).
