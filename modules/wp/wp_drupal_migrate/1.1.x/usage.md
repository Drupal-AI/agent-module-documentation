<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WordPress Drupal Migrate migrates WordPress content to Drupal via a direct database connection.

---

WordPress Drupal Migrate migrates **WordPress content into Drupal** — posts, taxonomy, media, comments and
menus — by connecting **directly to the WordPress database** and mapping its data through the Migrate API. It
depends on Migrate, Migrate Plus, Migrate Tools and several core content modules, provides its own permissions,
in the Migration package.

Use it to move a WordPress site into Drupal. It is a developer/migration feature. Security handling: it holds
**WordPress database credentials** (host/user/password) — store these as **secrets** (settings.php / env, not
committed config), and the connection should be to a **trusted** database. As a migration, run it on a staging
environment and review imported content (WordPress HTML becomes Drupal content — apply appropriate text
formats to avoid importing unsafe markup). It has no Drupal access-control role beyond its permission.
Configure the WordPress DB connection and run the migration.

---

- Migrate WordPress content to Drupal.
- Connect directly to the WP database.
- Import posts/taxonomy/media/comments/menus.
- Depend on Migrate/Migrate Plus/Migrate Tools.
- Map WP data via the Migrate API.
- Provide its own permissions.
- Store WP DB credentials as secrets.
- Connect to a trusted database.
- Apply safe text formats to imported HTML.
- Run on staging and review content.
- Have no Drupal access role beyond permission.
- Configure the WP DB connection.
- Handle WordPress migration.
- Migrate content.
- Configure the migration.
- Import WordPress.
- Handle the migration.
- Move WP content.
- Secure the credentials.
- Provide WordPress migration.
