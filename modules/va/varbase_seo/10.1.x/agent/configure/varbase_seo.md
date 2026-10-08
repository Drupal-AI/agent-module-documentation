<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — what Varbase SEO installs and sets

`varbase_seo` has **no configuration form of its own** (`configure` is `null`). All of its
"configuration" happens **once, at install time**, by running the bundled recipe. After install you
manage everything through the individual SEO modules' own admin UIs. This doc is a map of exactly
what the install produces so you know where to go and what to change.

## How install works

`varbase_seo_install()` (`varbase_seo.install`):

1. `Recipe::createFromDirectory(__DIR__ . '/recipes/default')` + `RecipeRunner::processRecipe()` —
   enables the module list, imports their config, applies overrides (details below).
2. `ModuleInstallerFactory::setModuleWeightAfterInstallation('varbase_seo', 'set_weight_after')` —
   sets this module's weight **after** every module in the `set_weight_after` list (info.yml) so its
   hooks/subscribers run last.
3. If `google_analytics` is enabled, imports `config/managed/google_analytics/google_analytics.settings.yml`.
4. Runs `EntityDefinitionUpdateManager::applyUpdates()` and force-imports `views.view.redirect_404`.

Re-running is not idempotent config-management: it is a one-shot bootstrap. To change anything after
install, edit the target module's config, not this module.

## Modules the recipe enables (`recipes/default/recipe.yml` → `install:`)

`metatag`, `eca_metatag`, `metatag_facebook`, `metatag_google_plus`, `metatag_hreflang`,
`metatag_mobile`, `metatag_open_graph`, `metatag_twitter_cards`, `metatag_verification`, `pathauto`,
`redirect`, `redirect_404`, `redirect_domain`, `schema_metatag`, `schema_article`, `schema_item_list`,
`schema_web_page`, `schema_web_site`, `simple_sitemap`, `yoast_seo`, `script_manager`, `entity_clone`.

`google_analytics` and `google_tag` are **composer requirements** (installed on disk) but are not in
the recipe `install:` list — they are wired up opportunistically: `hook_modules_installed` /
`hook_install` import the custom GA settings **if/when** `google_analytics` is enabled.

## Fields added to content (`node`)

- `field_meta_tags` — Metatag field (`field.storage.node.field_meta_tags`), lets editors override
  meta tags per node.
- `field_yoast_seo` — Real-Time SEO (Yoast) analysis field (`field.storage.node.field_yoast_seo`);
  the node form widget is relabeled to **"Real-time SEO analyzer"** by `VarbaseSeoHooks`.

Note: these are only field *storage* definitions; field instances/widgets are expected on Varbase
content types. On a non-Varbase site you attach the fields to bundles yourself.

## Metatag defaults shipped (`config/optional/metatag.metatag_defaults.*`)

| Context | Notable tags |
|---|---|
| `global` | `title = [current-page:title] \| [site:name]`, `canonical_url`, OG image from active theme `share-image.png` |
| `front` | front-page title/description/OG |
| `node` | `title = [node:title] \| [site:name]`, `description = [node:summary]`, `canonical_url = [node:url]`, OG image `[node:share-image]` |
| `taxonomy_term`, `user` | context titles/canonical |
| `403`, `404` | `robots: noindex`, canonical/shortlink to `[site:url]` |

`metatag.settings` maps which tag groups (basic, open_graph) apply to which node bundles
(`landing_page`, `page`, `varbase_blog`, `varbase_heroslider`, …).

## Config overrides the recipe applies (`recipe.yml` → `actions:`)

- **`pathauto.settings`**: `enabled_entity_types: [user]`, `max_length: 100`,
  `max_component_length: 100`, `transliterate: true`, hyphen separator, a curated `ignore_words`
  stop-list, `update_action: 2`, and `safe_tokens: [alias, path, join-path, login-url, url, url-brief]`.
- **`redirect.settings`**: `auto_redirect: true`, `default_status_code: 301`,
  `passthrough_querystring: true`, `deslash: true`, `frontpage_redirect: true`,
  `normalize_aliases: true`, `route_normalizer_enabled: true`, `term_path_handler: true`,
  `canonical: false`, `access_check: false`.
- **`simple_sitemap.settings`**: `max_links: 2000`, `cron_generate: true`, `remove_duplicates: true`,
  `skip_untranslated: true`, `xsl: true`, `enabled_entity_types: [node, taxonomy_term, menu_link_content]`.

## Permissions granted (recipe `grantPermissions`, only if the roles exist)

- `editor`, `content_admin`: `use yoast seo`.
- `seo_admin`, `site_admin`: `administer redirect settings`, `administer redirects`,
  `administer scripts`, `administer meta tags`, `use yoast seo`, `administer sitemap settings`,
  `clone script entity`.
- Ships `config_perms.custom_perms_entity.access_metatag_plugins_report` (a Custom Permissions entity
  granting access to route `metatag.reports_plugins`).

These roles are Varbase-provided; on a stock site they will not exist and the grants are simply skipped.

## Other shipped config

- `views.view.redirect_404` — a "Redirect 404" admin view (access gated by `administer redirects`),
  force-imported after entity updates.
- `google_analytics.settings` (managed) — privacy-friendly defaults: `anonymizeip: true`, empty
  `account`, tracking excluded on `/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*`,
  `/user/*/*`; outbound/mailto/file/colorbox tracking on. Applied only when GA is enabled — set your
  own tracking ID at `/admin/config/services/google-analytics`.

## Where to manage things after install

- Meta tags: `/admin/config/search/metatag`
- Pathauto (URL aliases): `/admin/config/search/path/patterns` and `/admin/config/search/path/settings`
- Redirects / 404s: `/admin/config/search/redirect`
- Sitemap: `/admin/config/search/simplesitemap`
- Schema.org metatag: via the Metatag defaults / field
- Scripts: `/admin/config/development/script-manager`
- Google Analytics: `/admin/config/services/google-analytics`
