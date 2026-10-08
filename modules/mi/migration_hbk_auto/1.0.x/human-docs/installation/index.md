# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- In practice the wider migration toolchain — **Migrate Plus**, **Migrate Tools**,
  **Migrate Upgrade**, and **Views Migration** — which Composer pulls in as
  dependencies.
- On the **Drupal 7 source site**: the **migrateexport** module, so this module
  can read the source data.
- An internet connection from the browser you use for the admin UI, since the Vue
  interface loads the Vue library from an external CDN.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migration_hbk_auto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the migration toolchain.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migration_hbk_auto -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migration_hbk_auto -y
```

> **Before you expose the site:** this module is **not covered by Drupal's
> security advisory policy**, and its import/config action endpoints are gated only
> by the *access content* permission (effectively anonymous) even though they
> create fields and file entities and write configuration. Run it only on a
> local/offline or otherwise locked-down build, restrict those routes, and disable
> or remove the module when the migration is finished.

## Verify it worked

After enabling, visit **Configuration → System → Migration settings**
(`/admin/config/system/migration-settings`) and confirm the settings form loads
(see [Configuration](../configuration/index.md)). Then open
`/admin/migration-hbk-auto/import-from-d7` and click **Load all entities** — if
your D7 source URL is set correctly and the D7 site has migrateexport installed,
you should see its entities listed.
