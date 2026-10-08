<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MySQL 5.7 (mysql57)

A database-driver shim, not a feature module. It subclasses core's `mysql` driver and only
lowers the minimum server version to MySQL 5.7.8+ / MariaDB 10.3.7+, so Drupal 10.2+/11 can
install and run on servers core's own driver would reject. No admin UI, no config form, no
permissions, no schema, no Drush, no hooks — depends on `drupal:mysql`, inheriting all query,
schema, and transaction behavior unchanged.

- **Point Drupal at the driver in `settings.php`** → [configure/settings-php.md](configure/settings-php.md)
