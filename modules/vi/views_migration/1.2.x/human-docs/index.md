# Views Migration — manual setup guide

**Views Migration** (`views_migration`) brings your **Views over from a Drupal 6 or 7
site** into Drupal 10/11. Drupal core's standard upgrade tooling (`migrate_drupal`)
migrates content, fields, and much of your configuration — but it deliberately skips
Views. This module fills that gap, turning each legacy view into a modern Drupal `view`
configuration entity, displays and handlers and all.

The hard part of a Views migration is translating every old handler — fields, filters,
sorts, arguments, pagers, styles, and so on — into the shape Drupal 10/11 expects.
Views Migration does this through an extensible set of handler plugins (21 handler
types in all), each of which knows how to rewrite one kind of handler for the new site.
For most standard views it works automatically, and developers can add their own handler
plugins to support contrib modules' Views integrations.

It ships two migrations — one for Drupal 7 (`d7_views_migration`) and one for Drupal 6
(`d6_views_migration`) — that plug into the familiar Migrate toolchain
(`migrate_plus` / `migrate_tools`). You run them with the same Drush commands and UI you
use for any other migration, so a Views migration slots neatly into an existing upgrade
process.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Migrate tools it
   builds on with Composer, then enable it.

## Where it lives in the admin menu

Views Migration adds **no settings page of its own**. You drive it through the standard
migration tools:

- The core **Upgrade** wizard at `/upgrade` (from `migrate_upgrade`/`migrate_drupal`) to
  register your old Drupal 6/7 database as the source.
- The **Migrate Tools** execute UI, or Drush, to run the migrations. For this module's
  migration group, the execute form gains an extra **Views ID List** field so you can
  import only selected views.

## How to use it

1. **Point Drupal at your old site's database.** Either run the core **Upgrade** UI at
   `/upgrade`, or add a `migrate` database connection in `settings.php` that the
   migrations can read. Views Migration doesn't configure the connection itself — it uses
   the same legacy source database as the rest of your Drupal 6/7 upgrade.
2. **Check what will migrate:**

   ```bash
   drush migrate:status d7_views_migration
   ```
3. **Run the migration:**

   ```bash
   drush migrate:import d7_views_migration                 # migrate all D7 views
   drush migrate:import d7_views_migration --idlist=frontpage,archive   # only these views
   drush migrate:import d7_views_migration --update        # re-import ones already migrated
   ```

   Use `d6_views_migration` instead for a Drupal 6 source.
4. **Roll back** if something needs fixing, then re-run:

   ```bash
   drush migrate:rollback d7_views_migration
   ```

If you prefer the UI, the Migrate Tools execute form for the **Views Migration** group
includes a **Views ID List** field — enter comma-separated view IDs to limit the run to
just those views. The result of a successful migration is standard Drupal `view` config
entities you can then edit in the normal Views UI.

Developers who need to customize how a particular handler migrates (or add support for a
contrib module's Views integration) can ship their own handler plugins — see the
[`agent/`](../agent/start.md) docs for the plugin types and interfaces.
