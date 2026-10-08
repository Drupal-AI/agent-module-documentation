<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Dependency (feeds_dependency) — agent index

Add-on for the **Feeds** module. Lets one Feeds importer be declared a *dependency* of another
so the dependency imports first (e.g. import a media feed before the node feed that references it).
It adds two base fields to the `feeds_feed` entity and swaps the feed's `feed_import` handler so
that import / cron / batch / push each run every referenced dependency feed before the current feed.

- Depends on the **Feeds** module (`feeds:feeds`; composer `drupal/feeds:~3.0`).
- **No settings page** (no configure route), no permissions, no drush commands, no config schema.
  A dependency is set per-feed via the two base fields on the feed's edit form.

## Solutions
- **Declare that one feed imports before another (UI or code)** → [fields/dependency.md](fields/dependency.md)
- **Understand the import-ordering mechanism and the clear-cascade** → [hooks/import-order.md](hooks/import-order.md)

## Key facts
- Base fields on `feeds_feed`: `feed_dependency_id` (entity_reference → `feeds_feed`, revisionable,
  translatable, autocomplete widget, weight 5) and `clear_dependency` (boolean, default `TRUE`,
  checkbox widget, weight 15).
- Overridden entity handler: `feed_import` → `Drupal\feeds_dependency\FeedDependencyImportHandler`
  (extends `Drupal\feeds\FeedImportHandler`).
- Trait `Drupal\feeds_dependency\FeedDependencyTrait`: `getFeedDependencies()`, `feedsNotSame()`,
  `clearFeedDependency()`.
- Hooks: `hook_entity_base_field_info`, `hook_entity_type_alter`,
  `hook_form_feeds_feed_confirm_form_alter`, `hook_help`.
- No config objects — state lives entirely in the two per-feed base-field values.
