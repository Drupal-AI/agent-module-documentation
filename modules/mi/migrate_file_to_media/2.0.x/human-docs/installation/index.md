# Installation

## Requirements

Migrate File To Media builds on Drupal's migration framework, so it pulls in a
few companion modules:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer**.
- **Migrate Tools** (`drupal/migrate_tools` `^6`) and **Migrate Plus**
  (`drupal/migrate_plus` `^6`) — installed via Composer alongside this module.
- Core's **Media**, **File**, **Migrate**, and **Migrate Drupal** modules, which
  Drupal enables as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_file_to_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Tools,
Migrate Plus, and any shared dependencies they need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_file_to_media -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_file_to_media -y
```

Drupal will enable the required core Media, File, Migrate, and Migrate Drupal
modules along with Migrate Tools and Migrate Plus if they are not already on.

## Optional: the example submodule

The project ships **Migrate File To Media Example**
(`migrate_file_to_media_example`), a complete, working Article image migration
you can read and copy from. Enable it if you want a template to start from:

```bash
drush en migrate_file_to_media_example -y
```

It is only there as a worked example — you would not keep it enabled on a
production site.

## Verify it worked

The module has no settings page, so the easiest check is that its Drush commands
are registered:

```bash
drush list --filter=migrate | grep file-media
```

You should see `migrate:file-media-fields` (alias `mf2m`) among the results. From
there, follow the step-by-step flow in the [overview](../index.md#how-to-use-it).
