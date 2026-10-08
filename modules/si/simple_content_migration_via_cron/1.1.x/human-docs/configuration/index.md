# Configuration

This module has **no settings form in the admin UI**. You configure it entirely in
your site's `settings.php` (or a `settings.local.php`), by defining a schedule of
migrations for cron to run. This page walks through that block.

## The migration schedule

Add a `migrations` list to the module's config override. Each key is the machine
name of a migration you want cron to run:

```php
$config['simple_content_migration_via_cron']['migrations'] = [
  'content_migration' => [
    'time'   => 3600,  // minimum seconds between runs (here: hourly)
    'update' => TRUE,  // optional: re-import rows already migrated
    'sync'   => TRUE,  // optional: delete destination rows missing from source
  ],
];
```

Field by field:

- **The map key** (`content_migration` above) — the machine name of the migration
  to run. Use the bundled example name, or the machine name of any migration you
  have defined yourself.
- **`time`** — the throttle interval in **seconds**. The migration runs on the
  first cron pass after this many seconds have elapsed since its last run. The
  module tracks this per migration with a `<key>_next_execution` timestamp, so a
  short cron frequency will not run a job more often than its interval allows.
- **`update`** *(optional)* — when `TRUE`, the migration re‑imports rows it has
  already processed (the equivalent of Drush's `--update`). Use it when source
  rows change and you want those changes pulled in on each run.
- **`sync`** *(optional)* — when `TRUE`, destination items whose source rows have
  disappeared are removed (the equivalent of `--sync`). Use it with care: it
  deletes content that no longer exists in the source.

You can list several migrations at once — each gets its own interval and flags, and
cron drives them independently from a single run. On each due run the migration is
forced to an idle status first, then imported, and a name that no longer resolves
to a real migration is skipped safely rather than breaking cron.

## Pick a cron frequency

In **Configuration → System → Cron** (`/admin/config/system/cron`) choose a cron
run frequency at least as often as your shortest migration interval, and save.
Drupal's built‑in Cron API is what actually triggers the migrations, so if cron
never runs, the migrations never run.

## The bundled example migration

The module ships an example migration, `migrate_plus.migration.content_migration`,
that uses the included `content_migration` SQL source plugin. That source reads a
`products` table (columns `title`, `sku`, `price`, `valid_date`, keyed by `sku`)
and maps it to a `product` content type with fields `title`, `field_sku`,
`field_price`, and `field_valid_date`.

To adapt it to your own data:

- If your content type's machine name differs, change `default_bundle` in
  `config/install/migrate_plus.migration.content_migration.yml`.
- Adjust the source fields for your table in the source plugin `Content.php`.
- Map your source fields to your destination fields in the migration YAML.

For your own imports you will typically define fresh Migrate Plus migration config
entities and simply add their machine names to the `migrations` list above.
