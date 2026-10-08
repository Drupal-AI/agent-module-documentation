<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WordPress Migrate SQL migrates WordPress content into Drupal from a WordPress SQL database.

---

WordPress Migrate SQL migrates WordPress content into Drupal by reading directly from a WordPress **SQL
database** — mapping WordPress posts/pages/taxonomies/users to Drupal entities via the Migrate API, an
alternative to XML/WXR-based WordPress migration. It ships a `wordpress_migrate_sql_basic` submodule, provides
Drush commands, depends on core Migrate, in the Migrate package.

Use it to import a WordPress site from its database. Security/operational notes: it connects to the WordPress
database with **database credentials** — store those securely (in `settings.php`/environment, not committed),
grant the connection **read-only** access where possible, and run migrations as a trusted operator (migration
is an admin/CLI activity). Imported content should be reviewed/sanitized as needed (content from another CMS).
It has no access-control role. Configure the source database connection and migrations.

---

- Migrate WordPress from its SQL database.
- Map WP posts/pages/taxonomies/users.
- Use the Migrate API.
- Provide an alternative to WXR migration.
- Ship a basic submodule.
- Provide Drush commands.
- Store the WordPress DB credentials securely.
- Grant read-only DB access where possible.
- Run migrations as a trusted operator.
- Review/sanitize imported content.
- Have no access-control role.
- Configure the source DB connection.
- Import WordPress content.
- Handle the migration.
- Configure migrations.
- Connect to the WP database.
- Handle DB credentials securely.
- Migrate from WordPress.
- Import from SQL.
- Configure the source.
