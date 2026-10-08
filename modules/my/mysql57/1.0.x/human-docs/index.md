# MySQL 5.7 — manual setup guide

**MySQL 5.7** (`mysql57`) is a database‑driver shim, not a feature module. Drupal
11 core's built‑in `mysql` driver refuses to install or run on MySQL older than
8.0 or MariaDB older than 10.6 — a problem when a host or legacy environment only
offers, say, MySQL 5.7 or MariaDB 10.3–10.5. This module ships a tiny replacement
driver that subclasses core's `mysql` driver and does one thing: it lowers the
minimum server version to **MySQL 5.7.8+ / MariaDB 10.3.7+**. Everything else —
all query, schema, and transaction behavior — is inherited unchanged from core.

Because it only relaxes the version check, there is no admin interface: you wire
it up in `settings.php` by pointing each database connection at the module's
driver namespace. The project bundles a ready‑made `settings.inc` snippet so a
single `require` line converts every connection at once, or you can set each
connection by hand for granular control. On a fresh install the driver also shows
up on the installer's database‑selection screen as "MySQL 5.7 or MariaDB 10.3,
10.4, or 10.5."

Think of it as a bridge. Use it when upgrading the database server isn't an option
right now; once the server is on a core‑supported version, remove the
`settings.php` wiring and uninstall the module. It has **no configuration form, no
permissions, no schema, and no Drush commands**, and it depends on core's
**MySQL** module (`drupal:mysql`), whose behavior it reuses. It still enforces its
own minimums (5.7.8 / 10.3.7) and rejects anything older.

This guide is written for a **human** setting the site up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and point `settings.php` at the relaxed driver.

## Where it lives in the admin menu

Nowhere. MySQL 5.7 has no admin page. It is activated entirely by editing
`settings.php` (or by selecting the driver on the installer's database screen),
not through the Drupal UI.

## How to use it

Enabling the module alone does nothing — the driver only takes effect once a
database connection is repointed at it in `settings.php`. The full walkthrough,
including the one‑line bundled snippet and the manual per‑connection form, is on
the [Installation](installation/index.md) page, since the `settings.php` edit is
what actually makes the driver work.

When your database server is later upgraded to a core‑supported version (MySQL
8.0+ / MariaDB 10.6+), remove the `settings.php` wiring so connections fall back
to core's `mysql` driver, then uninstall this module.
