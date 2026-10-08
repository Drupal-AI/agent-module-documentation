# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Migrate** module (`migrate`) — enabled automatically as a dependency.

There are no third-party PHP library requirements.

> **Alpha release.** The version documented here is **3.0.0-alpha1**. Alpha
> software can change; test your migrations before relying on it in production.

### Useful companion modules

These are not hard dependencies, but you will usually want some of them:

- **Migrate Plus** (`drupal/migrate_plus`) — provides the Migration config entity
  and extra source plugins (`embedded_data`, `url`, `csv`) that pair well with
  these process plugins.
- **Migrate Tools** (`drupal/migrate_tools`) — Drush commands to run and roll back
  your migrations.
- **Remote Stream Wrapper** (`drupal/remote_stream_wrapper`) — *required* if you
  use `file_remote_url` or `file_remote_image`, since those store a remote URI
  without downloading and need a stream wrapper to serve it.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the common companions at the same time:

```bash
composer require drupal/migrate_file drupal/migrate_plus drupal/migrate_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_file -y
```

That's the whole setup. There is no configuration form — once enabled, the four
process plugins (`file_import`, `image_import`, `file_remote_url`,
`file_remote_image`) are available to use in your migration definitions. See the
[overview](../index.md) for usage examples.
