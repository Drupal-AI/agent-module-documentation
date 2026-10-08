# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- Core's **Media** module (`media`).
- The contributed **Migrate Plus** module (`drupal/migrate_plus`) — used by the
  DOM inline‑handler plugins.

There are no additional PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_media_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_media_handler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_media_handler -y
```

Drupal enables core Migrate, core Media, and Migrate Plus automatically as
dependencies if they are not already on. On install, the module adds a helper
field (`field_original_ref`) to each media bundle so it can record a file‑hash
reference and dedupe media on later runs; uninstalling the module removes that
field again.

## Verify it worked

Confirm the module and its dependencies are enabled (**Extend** page, or
`drush pm:list --status=enabled`). There is no settings form to visit — configure
the module's behaviour with `drush config-set` on `migrate_media_handler.settings`
(see the [overview page](../index.md)), then reference the process plugins from
your migration YAML.
