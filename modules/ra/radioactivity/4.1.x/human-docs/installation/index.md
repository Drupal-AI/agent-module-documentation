# Installation

## Requirements

Radioactivity needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`), enabled automatically as a dependency.
- A working **cron** — Radioactivity processes view events and applies decay on
  cron runs, so your site needs cron running regularly for popularity values to
  update and fade.

There are no third‑party Composer or PHP library requirements. (Rules integration
is optional and only needed for development/testing of the Rules event.)

## Install with Composer

From the project root:

```bash
composer require drupal/radioactivity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/radioactivity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en radioactivity -y
```

There's no settings page to visit. Next, add a Radioactivity field to a content
type and configure its behavior — see [Configuration](../configuration/index.md).

## A useful Drush command

Radioactivity ships one Drush command:

```bash
drush radioactivity:fix-references
```

Run it after adding a **Radioactivity reference** field to content that already
exists (or after a migration) to backfill the referenced radioactivity entities
that new field instances are missing. If a field is missing its target, the status
report will flag an error pointing you to this command.
