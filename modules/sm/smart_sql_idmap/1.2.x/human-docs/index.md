# Smart SQL ID Map — manual setup guide

**Smart SQL ID Map** (`smart_sql_idmap`) is a small, developer-focused module for
Drupal migrations. It provides a drop-in replacement for core's `sql` migration
ID-map plugin — called `smart_sql` — that generates correctly-named, non-colliding
map and message tables even when a migration has a very long or derived plugin ID.

Every Drupal migration keeps two bookkeeping tables (a *map* table and a *message*
table) named after the migration's ID. MySQL limits identifiers to 63 characters,
and core's naming can silently truncate long names past that limit — which, in the
worst case, makes two different migrations point at the *same* table and quietly
corrupt their ID lookups. This is common with Drupal 7 upgrades that produce deep,
derived migration IDs like `d7_field_instance:node:article`. Smart SQL ID Map
recomputes the table names so they always fit and stay unique (truncating and
appending a short, stable hash of the ID when needed), and it also works around a
couple of related core migrate bugs affecting `getRowByDestination()` and
rollback.

There is nothing to configure — no settings page, no permissions, no services, no
Drush commands. The module's entire surface is the plugin ID you reference from a
migration definition. It depends only on core's **Migrate** module, and it affects
only the migrations that opt into it; everything else keeps using core's `sql`
map.

This guide is written for a **human** clicking through the admin UI (well, mostly
a developer editing migration YAML). If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no admin UI. You use the module by referencing its plugin in a
migration definition.

## How to use it

Opt a migration into the smarter ID map by setting its `idMap` plugin to
`smart_sql` in the migration definition:

```yaml
# in your migration's YAML (e.g. a migrate_plus config entity)
id: my_really_long_migration_id_that_would_otherwise_truncate
# ...
idMap:
  plugin: smart_sql
```

That's the whole setup. When you run the migration, it uses correctly-named,
unique map and message tables. Apply it only to the migrations that need it (those
with long or derived IDs), or standardize on it across a large multi-migration
upgrade — either way, source, process, and destination configuration stay exactly
the same.

It pairs naturally with `migrate_plus` and `migrate_tools`, and is best thought of
as a compatibility shim you can keep until every core release you run includes the
upstream fixes.
