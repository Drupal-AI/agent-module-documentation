# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- **PHP 7.3** or newer.
- **Drush 9** or newer — this is a Drush‑driven module, so Drush is essential.
- Core's **Migrate** (`migrate`) and **Migrate Drupal** (`migrate_drupal`)
  modules, plus **Migrate Plus** (`migrate_plus` 5+). Composer and Drupal pull
  these in as dependencies.
- A **legacy Drupal 6 or 7 site** (its database, and its files if you want to
  migrate them) to upgrade from.
- **Optional but recommended:** [Migrate Tools](https://www.drupal.org/project/migrate_tools)
  if you plan to use the `--configure-only` workflow, so you can run and roll back
  the generated migrations selectively.

Run everything on a **freshly installed, empty target site** with only the
destination modules you want to migrate into enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_upgrade -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_upgrade -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_upgrade -y
```

This enables the migrate dependencies alongside it. There are no submodules and
no configuration form.

## Next step

Migrate Upgrade has no settings — you drive it entirely with Drush. See the
[overview](../index.md) for the `migrate:upgrade` and `migrate:upgrade-rollback`
commands and their options.
