MySQL 5.7 provides a Drupal database driver that subclasses core's `mysql` driver but lowers the minimum server-version requirement, letting Drupal 10.2+/11 install and run against MySQL 5.7.8+ or MariaDB 10.3.7+ (versions core's own driver rejects).

---

Drupal 11 core's built-in `mysql` driver enforces MySQL 8.0 / MariaDB 10.6 as its minimum supported database server, blocking installation on older-but-still-common servers. The MySQL 5.7 module ships a tiny replacement driver in `src/Driver/Database/mysql/` whose `Connection` is an empty subclass of core's `Drupal\mysql\Driver\Database\mysql\Connection`, and whose install `Tasks` subclass only overrides the two version constants (`MYSQL_MINIMUM_VERSION = '5.7.8'`, `MARIADB_MINIMUM_VERSION = '10.3.7'`) plus the driver's display name shown on the installer's database screen. Because it merely relaxes the version check, all real query, schema, and transaction behavior is inherited unchanged from core mysql — the module depends on `drupal:mysql`. It is wired up not through the admin UI but through `settings.php`: you point each database connection's `namespace` at `Drupal\mysql57\Driver\Database\mysql` and set an `autoload` path, declaring core's `mysql` module as a dependency of the driver. The project bundles a ready-made `settings.inc` snippet that does this for every connection via an IIFE, so a single `require` line in `settings.php` converts a site to the relaxed driver. There is no configuration form, no permissions, no schema, and no Drush commands — the module is purely a database-layer shim. Use it when a host or legacy environment only offers MySQL 5.7 / MariaDB 10.3–10.5 and upgrading the server is not an option; remove it once the database server is upgraded to a core-supported version.

---

- Install Drupal 11 on a server that only provides MySQL 5.7.8+ instead of the core-required MySQL 8.0.
- Install or run Drupal on MariaDB 10.3.7, 10.4, or 10.5 where core demands MariaDB 10.6+.
- Keep an existing Drupal site running after a core upgrade that would otherwise fail the database minimum-version requirement.
- Deploy to shared or managed hosting that pins an older MySQL/MariaDB release you cannot change.
- Point `settings.php` at the relaxed driver by including the bundled `settings.inc` snippet.
- Convert every database connection (default, replica/slave, migrate source) to the mysql57 namespace in one step via the IIFE snippet.
- Manually set a single connection's `namespace` to `Drupal\mysql57\Driver\Database\mysql` when you want granular control.
- Get past the installer's database version guard by selecting the "MySQL 5.7 or MariaDB 10.3, 10.4, or 10.5" driver on the install screen.
- Buy time to schedule a database-server upgrade without blocking site delivery.
- Run local development against a legacy MySQL 5.7 container that matches an old production server.
- Restore and boot a backup onto infrastructure whose database engine predates core's supported baseline.
- Bridge a staged migration where application code is on Drupal 11 before the DB server is upgraded.
- Avoid forking or patching Drupal core just to change two version constants.
- Provide a drop-in driver whose query/schema/transaction behavior is byte-for-byte core mysql.
- Standardize a fleet of sites onto one relaxed-driver include so environments stay consistent.
- Document/enforce a known-good minimum (5.7.8 / 10.3.7) rather than letting core reject the server outright.
- Combine with a multi-connection setup so only specific targets use the relaxed driver.
- Remove the module cleanly once the database server is upgraded, reverting `settings.php` back to core `mysql`.
- Subclass the shim further (extend its `Connection`) if you need custom behavior on top of relaxed versioning.
- Verify at install time that the DB is at least 5.7.8 / 10.3.7 (the module still rejects anything older).
