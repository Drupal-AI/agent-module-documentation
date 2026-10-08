<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase SEO (varbase_seo) — agent index

A **feature/bundle module** from the Varbase distribution. It has almost no runtime code of its own;
its job is to **install and pre-configure a stack of SEO contrib modules** and ship opinionated
default configuration. Enabling it runs a bundled **Drupal recipe** (`recipes/default/recipe.yml`)
from `hook_install()` that enables the modules below, imports their config, and applies overrides.

Modules the recipe installs: `metatag` (+ `metatag_facebook`, `metatag_google_plus`,
`metatag_hreflang`, `metatag_mobile`, `metatag_open_graph`, `metatag_twitter_cards`,
`metatag_verification`), `eca_metatag`, `pathauto`, `redirect`, `redirect_404`, `redirect_domain`,
`schema_metatag` (+ `schema_article`, `schema_item_list`, `schema_web_page`, `schema_web_site`),
`simple_sitemap`, `yoast_seo`, `script_manager`, `entity_clone`. `google_analytics` / `google_tag`
are composer requirements wired up when present (see configure doc).

- Package: **Varbase**. Core: `~11.4.0`. License: GPL-2.0-or-later.
- **No `configure` route, no permissions.yml, no services, no plugin types, no Drush commands, no
  config schema of its own.** `info.yml` declares **no** `dependencies:` — the module list is pulled
  by the recipe/composer, not by Drupal module dependencies.
- Composer requires: core + `vardot/varbase-patches` + the SEO modules above.
- Designed for Varbase (references its editorial roles and content types) but installable on any
  Drupal 11 site.

## What you'd do → where

- **Understand what gets installed/configured, the shipped config (metatag defaults, pathauto/
  redirect/sitemap settings, fields, roles/permissions granted), and how to change it** →
  [configure/varbase_seo.md](configure/varbase_seo.md)

## Key facts (real machine names)

- Install logic: `varbase_seo_install()` (`varbase_seo.install`) → `Recipe::createFromDirectory(recipes/default)` +
  `RecipeRunner::processRecipe()`, then `ModuleInstallerFactory::setModuleWeightAfterInstallation('varbase_seo', 'set_weight_after')`.
- Own code: one `#[Hook]` class `Drupal\varbase_seo\Hook\VarbaseSeoHooks` with 4 hooks —
  `form_node_form_alter` (relabels Yoast widget to "Real-time SEO analyzer"),
  `form_metatag_defaults_edit_form_alter` (rebuilds the form via `metatag.manager`, moves the status
  checkbox), `modules_installed` (imports custom `google_analytics.settings` when `google_analytics`
  is enabled), `pathauto_punctuation_chars_alter` (adds typographic + Arabic-script punctuation).
- Shipped fields: `field_meta_tags` (type `metatag`) and `field_yoast_seo` (type `yoast_seo`) on `node`.
- Shipped config: `config/optional/metatag.metatag_defaults.{global,front,node,taxonomy_term,user,403,404}`,
  `metatag.settings`, `views.view.redirect_404`, `config_perms.custom_perms_entity.access_metatag_plugins_report`;
  `config/managed/google_analytics/google_analytics.settings.yml` (applied only when GA is enabled).
- Recipe config overrides: `pathauto.settings`, `redirect.settings`, `simple_sitemap.settings`, and
  `grantPermissions` on roles `editor`, `content_admin`, `seo_admin`, `site_admin`.
- `set_weight_after` (info.yml) lists the SEO modules; the module re-weights itself to run after them.
