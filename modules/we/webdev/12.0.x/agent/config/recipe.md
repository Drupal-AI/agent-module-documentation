<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webdev default recipe — bundle, config and operation

Webdev is a meta-package: it contributes no routes, services, permissions or config schema. All of
its behaviour is the Composer dependency set plus the recipe applied at install time.

## Install / enable

`webdev.install` → `webdev_install($is_syncing)`:

- Returns early when `\Drupal::isConfigSyncing()` is true (a config import brings its own config).
- Otherwise, when `!$is_syncing`, applies the sibling recipe:
  `RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`.

So enabling the module on its own runs the recipe; when the recipe itself installs `webdev` (it lists
`webdev` last, after its deps), the recipe is already applied and the guard prevents a double run.

`composer require drupal/webdev` pulls every module in `composer.json` `require` (core `^11.4 || ^12`).
Note that being *required* by Composer means downloaded/available — it does **not** mean enabled. Only
the modules in the recipe's `install:` list are enabled.

## Modules the recipe installs and ENABLES

From `recipes/default/recipe.yml` `install:` —

- Core dev/site-building contrib: `ctools`, `token`, `diff`, `pathauto`, `metatag`, `field_group`,
  `smart_trim`, `entityqueue`, `inline_entity_form`, `better_exposed_filters`, `link_attributes`,
  `token_filter`.
- UI Patterns 2: `ui_patterns`, `ui_patterns_blocks`, `ui_patterns_field`,
  `ui_patterns_field_formatters`, `ui_patterns_layouts`, `ui_patterns_library`, `ui_patterns_views`.
- UI Styles: `ui_styles`, `ui_styles_block`, `ui_styles_library`, `ui_styles_ui_patterns`.
- UI Icons: `ui_icons`, `ui_icons_library`, `ui_icons_patterns`.
- UI Skins: `ui_skins`.
- Display Builder: `display_builder`, `display_builder_entity_view`, `display_builder_page_layout`,
  `display_builder_ui`, `display_builder_views`.
- Finally `webdev` itself.

(Confirmed enabled on this site via `drush pml --status=enabled`.)

## Composer-required but NOT enabled by the recipe

These are in `composer.json` `require` but absent from the recipe `install:` list, so they are
downloaded and left **disabled** for the site builder to enable on demand:

- `shield` (`~1.0`), `devel` (`~5.0`), `user_redirect` (`~2.0`), `autocomplete_deluxe` (`~2.0`).

## Config the recipe imports

`config:` block, `strict: false`:

- `import:` `'*'` for each of `ctools`, `token`, `diff`, `pathauto`, `metatag`, `field_group`,
  `smart_trim`, `entityqueue`, `inline_entity_form`, `better_exposed_filters`, `link_attributes`,
  `token_filter` — i.e. each module's `config/install` defaults.
- `display_builder:` imports only two optional config items (optional config is not auto-installed by
  recipes): `display_builder.profile.default` and `filter.format.display_builder_html`.

### Provisioned Pathauto pattern

The recipe ships one config file, `recipes/default/config/pathauto.pattern.content.yml`, applied after
the modules install. It creates a Pathauto URL-alias pattern:

- `id: content`, `label: Content`, `type: 'canonical_entities:node'`, `pattern: '[node:title]'`,
  `status: true`, depends on module `node`, no selection criteria.

So every node gets a URL alias derived from its title out of the box. View it at
`/admin/config/search/path/patterns`:

![Pathauto patterns page showing the provisioned Content pattern /[node:title]](../../../../../../../screenshots/webdev/12.0.x/pathauto-patterns.png)

## Operating the resulting toolset

- Adjust or add URL-alias patterns at `/admin/config/search/path/patterns`; bulk-generate aliases at
  `/admin/config/search/path/update_bulk`.
- Build component-based displays, page layouts and views with UI Patterns / Display Builder
  (`/admin/appearance/ui` and the Display Builder UI); apply utility classes via UI Styles and icons
  via UI Icons.
- Manage meta tags (Metatag), field grouping (Field Group), teaser trimming (Smart Trim), inline
  referenced-entity editing (Inline Entity Form), curated entity lists (Entityqueue), revision
  comparison (Diff), token insertion in text (Token Filter), and richer exposed filters in Views
  (Better Exposed Filters).
- To use Devel, Shield, User Redirect or Autocomplete Deluxe, enable them explicitly
  (`drush en <module>`); the recipe intentionally leaves them off.
- Removing the meta-package does not disable the modules it enabled — uninstall those individually if
  a site does not need them.

## Notes / drift

- The bundled set changed vs `11.0.x`: `12.0.1` adds `entityqueue` and the full UI Suite
  (`ui_patterns`, `ui_styles`, `ui_icons`, `ui_skins`) plus `display_builder`, and now supports
  Drupal 12 (`^11.4 || ^12`). The project page's older module list (Custom Permissions, Anonymous
  Redirect, Default Content) does not match `12.0.1`'s actual `composer.json`.
