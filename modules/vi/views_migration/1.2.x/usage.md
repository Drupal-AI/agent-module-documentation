<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Migration migrates Drupal 6/7 Views into Drupal 10/11 as `view` config entities, translating each legacy view's displays and handlers into their modern equivalents through an extensible plugin system.

---

Core's `migrate_drupal` does not migrate Views, so this module fills that gap. It ships two migrations — **`d7_views_migration`** and **`d6_views_migration`** — in a **`views_migration`** migration group (built on migrate_plus/migrate_tools), each using a custom source plugin (`d7_views_migration` / `d6_views_migration`) that reads legacy `views_view`/`views_display` data and a custom destination plugin **`entity:view`** that writes Drupal view config entities. The hard part — turning a D7 handler's `display_options` into valid D10/11 Views config — is delegated to a large family of **21 pluggable handler/plugin managers** (`plugin.manager.migrate.views.<type>` for access, area, argument, argument_default, argument_validator, base_table, cache, display, exposed_form, field, field_formatter, handler_table, filter, pager, relationship, query, row, sort, style, style_summary, text_format), each with its own annotation (e.g. `@MigrateViewsField`) and default `d7_default` plugin. For any given handler the manager picks the plugin whose id matches the handler's plugin id (falling back to the default) and calls its `alterHandlerConfig()` to rewrite tables, fields, formatters, tokens and plugin ids for the new site. You configure a D7/D6 source database (via the core Upgrade / `migrate_upgrade` flow), then run the migrations with Drush (`drush migrate:import d7_views_migration`) or the migrate_tools UI, where a form alter adds a **"Views ID List"** field to import only selected view ids. It adds no permissions, config schema, Drush commands (it reuses migrate_tools') or `configure` route of its own.

---

- Migrate all Views from a Drupal 7 site into a new Drupal 10/11 site.
- Migrate Views from a Drupal 6 site as part of a D6→D10 upgrade.
- Bring legacy views across after running the standard core `migrate_drupal` upgrade.
- Import only specific views by id using the "Views ID List" field or `--idlist`.
- Re-run a view migration with `--update` after fixing source data.
- Roll back migrated views with `drush migrate:rollback d7_views_migration`.
- Check migration progress with `drush migrate:status d7_views_migration`.
- Preserve a view's displays (page, block, feed) through the migration.
- Translate D7 field handlers into D10 Views field configuration automatically.
- Convert D7 filter/sort/argument handlers to their modern equivalents.
- Map legacy base tables (e.g. commerce_product) to the new site's structure.
- Migrate exposed form settings including Better Exposed Filters where supported.
- Carry pager, style and row plugin settings across during migration.
- Handle Views Bulk Operations and Views Data Export display/style migration.
- Customize how a particular handler migrates by adding a `@MigrateViewsField` (etc.) plugin.
- Support a contrib field's views integration by shipping a custom migrate views handler plugin.
- Override the default table mapping for a handler via a base_table/handler_table plugin.
- Migrate views tag, description and human name into the new view's metadata.
- Stage a views migration in a group so it runs alongside other migrate_plus migrations.
- Selectively migrate and validate a few high-value views before importing the rest.
- Integrate a views migration into an automated upgrade pipeline using migrate_tools Drush.
- Recover missing views after an incomplete core upgrade that skipped Views.
