<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web SEO (webseo) — agent index

Meta-package (part of the Webship `web*` suite) that installs and pre-configures the most
commonly needed SEO contrib modules via a bundled recipe. Version **12.0.1** (dir `12.0.x`).
Core `^11.4 || ^12` (D12 support added over 11.0.x). License GPL-2.0-or-later.

## What it is
Thin PHP: no routes, permissions, services YAML, config schema or settings form of its own.
It ships:
- Composer dependencies on the bundled SEO modules (see `data.json` `composer_requirements`):
  `metatag`, `schema_metatag`, `pathauto`, `token`, `redirect`, `xmlsitemap`, `yoast_seo`,
  `easy_breadcrumb`, `google_analytics`, `google_tag`.
- `webseo.install` — `webseo_install($is_syncing)` applies `recipes/default` when the module is
  installed on its own (skipped during config sync / when the recipe itself installs the module).
- Two OOP `#[Hook]` classes in `src/Hook/` (autowired; no `*.services.yml` needed).
- `recipes/default/**` — the install recipe: module list, config imports, a Pathauto pattern,
  a redirect View, a shortcut, and config actions.

## Dependencies (installed by the recipe)
Recipe `install:` list also enables core `node`, `views`, `user`, `language`, `shortcut` and the
Metatag submodules (`metatag_mobile`, `metatag_open_graph`, `metatag_twitter_cards`,
`metatag_verification`), Schema.org submodules (`schema_article`, `schema_item_list`,
`schema_web_page`, `schema_web_site`), `redirect_404`, `redirect_domain`, plus `webseo` itself.

## Solution docs
- [agent/config/recipe.md](config/recipe.md) — what the meta-package installs and configures:
  the `recipes/default` recipe, the "Menu Path" Pathauto pattern, the redirect admin View,
  the "Set up a redirect" shortcut, and the config actions/defaults.
- [agent/hooks/hooks.md](hooks/hooks.md) — the two hook classes: `MetatagHooks::metatagsAlter()`
  (drop empty `[current-page:title]`) and `XmlSitemapHooks::cron()` (strip `/core/install.php`
  from the sitemap base URL).

No settings route (`configure: null`). The real admin UI belongs to the bundled modules.
