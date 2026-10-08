# WordPress Migrate Drush commands

Modern Drush command class: `src/Drush/Commands/WordpressMigrateCommands.php` (Drush 12/13 attributes,
autowired). Drush 8 code has been removed.

## `wordpress_migrate:generate`

Alias `wordpress-migrate-generate`. Generates the migration config entities from a WXR file (same work
as the programmatic generator).

```bash
drush wordpress_migrate:generate sites/default/files/my_wp_export.xml

drush wordpress_migrate:generate /var/data/my_wp_export.xml \
  --group-id=old_blog --prefix=blog_ \
  --tag-vocabulary=tags --category-vocabulary=wp_categories \
  --post-type=article --post-text-format=restricted_html \
  --page-type=page --page-text-format=full_html \
  --image-field=field_image
```

Argument: `file_uri` — Drupal stream wrapper (`private://my_wp_export.xml`) or an absolute path on the
machine running Drush.

Key options (all optional; defaults come from `wordpress_migrate.settings` `defaults`):
`--group-id`, `--prefix`, `--base-url`, `--default-author`, `--tag-vocabulary`, `--category-vocabulary`,
`--post-type`, `--post-body-field`, `--post-body-field-type`, `--post-text-format`, `--page-type`,
`--page-body-field`, `--page-body-field-type`, `--page-text-format`, `--image-field`. Output is a table
of created migration ids (supports `--format=`).

If `--group-id` is omitted a unique one is generated (e.g. `wp_2024_06_05__12_00_00`). Pre-flight
validation runs first; on any error nothing is generated and the command exits.

Widen the help table in DDEV: `COLUMNS=110 ddev drush help wordpress_migrate:generate`.

## `wordpress_migrate:help`

Alias `wordpress-migrate-help`. Prints a short usage reminder.

## Running the generated migrations

Use Migrate Tools (`drush migrate:import`, `migrate:status`, `migrate:rollback`, `migrate:messages`) —
this module only *creates* the migrations.
