<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web SEO — the default recipe (what it installs & configures)

Source: `recipes/default/recipe.yml` (+ `config/` and `content/` under it). Applied by
`webseo_install()` (`webseo.install`) when the module is enabled standalone; skipped during
config sync and when the recipe itself installs `webseo` (see the `$is_syncing` guard and
`\Drupal::isConfigSyncing()` check).

Recipe name: `Web SEO - Default`, `type: install`. It applies core recipe
`core/recipes/content_editor_role` first (grants the content-editor role its base perms).

## Modules installed (`install:`)
SEO contrib: `easy_breadcrumb`, `google_analytics`, `google_tag`, `metatag` (+ submodules
`metatag_mobile`, `metatag_open_graph`, `metatag_twitter_cards`, `metatag_verification`),
`pathauto`, `redirect`, `redirect_404`, `redirect_domain`, `schema_metatag` (+ `schema_article`,
`schema_item_list`, `schema_web_page`, `schema_web_site`), `token`, `xmlsitemap`, `yoast_seo`,
and `webseo` itself. Core deps: `node`, `user`, `views`, `language`, `shortcut`.
(Note: `token` is installed via the recipe though not in the `composer.json` `require` — Pathauto
pulls it in; the module list is the authoritative enable set.)

## Config imported (`config.import`)
Full default config (`'*'`) of `google_analytics`, `google_tag`, `metatag`, `pathauto`,
`redirect`, `redirect_404`, `schema_metatag`, `xmlsitemap`, `yoast_seo`; plus
`shortcut.set.default`. `pathauto.pattern.menu_path` is listed under `config.strict` (treated
strictly — must match exactly).

## Config entities shipped by the recipe (`recipes/default/config/`)
- `pathauto.pattern.menu_path.yml` — Pathauto pattern **"Menu Path"** (`id: menu_path`),
  `type: canonical_entities:node`, pattern `/[node:menu-link:parents:join-path]/[node:title]`,
  weight 10, no selection criteria. Node aliases follow the menu-tree parents then the title.
  Admin: `/admin/config/search/path/patterns` (the provisioned "Menu Path" pattern below).

  ![Pathauto patterns page showing the provisioned "Menu Path" pattern](../../../../../../../screenshots/webseo/12.0.x/pathauto-patterns.png)
- `views.view.redirect.yml` — a View **"Redirect"** (`base_table: redirect`) with a page display
  at path `admin/config/search/redirect`. Fields: bulk form, From (`redirect_source__path`),
  To (`redirect_redirect__uri`), status code, language, created, operations. Exposed filters:
  From, To, grouped Status code (300/301/302/303/304/305/307), Original language. Access:
  `perm` → `administer redirects`. Pager: 50/page. Empty text: "There are no redirects yet."

## Content shipped (`recipes/default/content/`)
- `shortcut/add-redirect.yml` — default-set shortcut **"Set up a redirect"** →
  `internal:/admin/config/search/redirect/add`, weight 0.

## Config actions (`config.actions`)
- `easy_breadcrumb.settings` (simpleConfigUpdate): `applies_admin_routes: false`,
  `add_structured_data_json_ld: true` (emit Schema.org `BreadcrumbList`),
  `hide_single_home_item: true`, `capitalizator_mode: none`.
- `metatag.metatag_defaults.front` (set `tags`): front-page `title: [site:name]`,
  `canonical_url: [site:url]`, `shortlink: [site:url]` — so a title-less front page does not
  render as "| Site name".
- `redirect_404.settings` (simpleConfigUpdate): `suppress_404: true`.
- `system.performance` (simpleConfigUpdate): `cache.page.max_age: 900` (15 min),
  `css.preprocess: true`, `js.preprocess: true`.
- `user.role.content_editor` (grantPermission): `administer redirects`.

## Operating notes
- Standalone install: `drush en webseo -y` → recipe runs automatically.
- The recipe installs modules with the config installer in *syncing* mode, so a bundled module's
  own `config/install` entities are not auto-created; that is why the redirect View, the Pathauto
  pattern and the shortcut are shipped explicitly here.
- webseo has no settings form; manage each area in its own module's UI (Metatag at
  `/admin/config/search/metatag`, Pathauto patterns at `/admin/config/search/path/patterns`,
  redirects at `/admin/config/search/redirect`, XML sitemap at `/admin/config/search/xmlsitemap`).
