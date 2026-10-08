# Configuration

The only thing Data Migration Report needs configured is **where your source data
lives** — the database of the old Drupal 7 site you are migrating from. There are
two ways to provide it; pick whichever suits your workflow.

## Option A — define the source connection in settings.php

Add a second database connection keyed `migrate`, alongside your normal `default`
connection, in `settings.php` (or `settings.local.php`). It describes how to reach
the source database, for example:

```php
$databases['migrate']['default'] = [
  'database' => 'drupal7_source',
  'username' => 'user',
  'password' => 'password',
  'host'     => 'db',
  'port'     => '3306',
  'driver'   => 'mysql',
  'prefix'   => '',
];
```

This is the standard Drupal migration approach and keeps the credentials out of
the site's exported configuration. Adjust the values to match your source
database.

## Option B — configure it through the UI

If you would rather not edit `settings.php`, the module provides a form at
**`/admin/config/system/migrate-database-credentials`**. Fill in the source
database's connection details (database name, username, password, host, port, and
so on) and save. The module then uses those credentials as the `migrate`
connection.

> Whichever option you choose, these are credentials for a database — treat them
> as sensitive, and prefer the `settings.php` approach on production‑like
> environments so the values are not stored in the site's configuration.

## After the connection is set

With the source database reachable, run the Drush commands (see the
[overview page](../index.md)):

```bash
drush generate:content-mapping
drush migration:test <entity_type> <bundle> --limit=<n> --ids=<id,id,…>
```

`generate:content-mapping` writes the YAML mapping of source fields to Drupal
fields; `migration:test` runs a test migration for the given entity type and
bundle and prints a validation report you can review before doing the real
migration.
