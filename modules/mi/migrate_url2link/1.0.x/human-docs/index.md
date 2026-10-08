# Migrate URL2Link — manual setup guide

**Migrate URL2Link** (`migrate_url2link`) is a small helper for site upgrades: it teaches
Drupal's migration system how to convert the **Drupal 7 contrib URL field** into the core
**Link** field when you move a site from Drupal 7 up to Drupal 8, 9, 10, or 11. Without it,
those old URL fields are flagged as "will not be upgraded" and their data is left behind.

The module is pure migration glue — it has no user interface, no settings, no permissions and
no Drush commands of its own. Under the hood it supplies one migrate field plugin that maps
the D7 `url` field type to the core `link` type, maps the old display formatters
(`url_default`, `url_plain`) to the `link` formatter, maps the old `url_external` widget to
the core `link_default` widget, and marks the D7 `url` module as fully handled so the upgrade
readiness report stops warning about it.

You simply enable it **before** running the standard Drupal‑to‑Drupal migration — whether you
drive that from the Migrate Drupal UI or with a
[migrate_plus](https://www.drupal.org/project/migrate_plus) configuration and
`drush migrate:import`. The plugin is discovered automatically and your URL fields convert to
Link fields with no hand‑written mappings. It depends on core's **Link** and **Migrate**
modules plus contrib **Migrate Plus**.

This guide is written for a **human** running an upgrade. If you want the exact plugin
definition, the formatter/widget maps and the migration‑state file for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is nothing to configure. The module only needs to be **present and enabled while the
migration runs**:

1. Set up your Drupal 7 → Drupal 8/9/10/11 migration as usual (Migrate Drupal UI, or a
   `migrate_plus` migration group + Drush).
2. **Before** you import, make sure `migrate_url2link` is enabled on the destination site.
3. Run the migration. D7 URL fields (and their widgets/formatters) are converted to core
   Link fields automatically, and the "URL module not upgraded" warning disappears from the
   readiness/audit report.
4. Once the upgrade is finished you can safely uninstall the module — it plays no role at
   runtime.
