# Drupal 8+ to Drupal 8+ migration — manual setup guide

**Drupal 8+ to Drupal 8+ migration** (`migrate_drupal_d8`) is a developer tool for
copying content from one modern Drupal site into another. It provides a single,
reusable migrate **source plugin** — `d8_entity` — that reads any content-entity
type, together with its Field API values, straight out of another Drupal 8, 9, 10,
or 11 site's database. You then use core's Migrate framework (usually with
Migrate Plus and Migrate Tools) to map and import that content into your new site.

Unlike core's built-in Drupal-to-Drupal upgrade path, which is aimed at upgrading
from Drupal 7, this module is designed for **modern-to-modern** moves: consolidating
several Drupal 8+ sites into one, re-platforming a Drupal 8 site to Drupal 11 while
restructuring content types, or seeding a new site from a production snapshot. It
reads the source database directly with read-only SQL, so the source site is never
modified, and it works even when the source site's REST or JSON:API is unavailable.

You point the plugin at a database connection (declared in your `settings.php`), an
entity type such as `node` or `user`, and optionally a single bundle. It then
builds the query and attaches every non-deleted field value as a source property
you can map in your migration. Because everything is driven from migration YAML,
there is **no admin UI, no settings form, no permissions, and no Drush commands of
its own** — you write migration definitions and run them with the Migrate tooling
you already use. That is why this guide has no separate configuration page; the
how-to below covers the essentials.

This guide is written for a **human**, but this module is genuinely code-oriented.
For the full plugin reference — every config key, the YAML shape, sub-field delta
syntax, and the deprecated aliases — read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has no admin pages. You use it entirely from migration YAML
and the command line via the Migrate framework.

## How to use it

### 1. Declare the source database

In `settings.php` (or `settings.local.php`) add a second database connection
pointing at the source site's database, under a key of your choosing:

```php
$databases['d8_source_site']['default'] = [
  'driver'   => 'mysql',
  'database' => 'd8_source_site',
  'username' => 'db_user',
  'password' => 'db_password',
  'host'     => '127.0.0.1',
  'port'     => 3306,
];
```

Keep these credentials out of version control — put them in your local settings or
an environment-driven include.

### 2. Reference the `d8_entity` source in a migration

In a migration definition (for example a Migrate Plus config entity), use
`d8_entity` as the source, pointing `key` at the connection above and
`entity_type` at what you want to migrate:

```yaml
source:
  plugin: d8_entity
  key: d8_source_site
  entity_type: node
  bundle: article
process:
  title: title
  'body/value': 'body/0/value'
  'body/format': 'body/0/format'
destination:
  plugin: 'entity:node'
  default_bundle: article
```

Plain properties map directly (`title: title`). Fields that have columns — like
`body`, link, or address — are addressed with a delta index, `field/<delta>/<column>`,
even for single-value fields (`body/0/value`).

### 3. Run it

Import and roll back with the Migrate Tools Drush commands you already use
(`drush migrate:import`, `drush migrate:rollback`). Omit the `bundle` key to
migrate every bundle of an entity type.

> **Tip:** the module also ships pre-typed aliases — `d8_node`, `d8_user`,
> `d8_file`, `d8_taxonomy_term` — but they are **deprecated**. Use `d8_entity` with
> an explicit `entity_type` instead.
