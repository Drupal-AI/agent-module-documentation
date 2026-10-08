# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **No other module dependencies** — Easy Migration relies only on Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_migration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_migration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_migration -y
```

## Submodules

Easy Migration ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Easy Migration Example** | `easy_migration_example` | A worked example that ports Drupal 7 content into the Drupal 10+ Entity API. Enable it to study a real `EasyMigration` plugin class before writing your own. |

Enable it with:

```bash
drush en easy_migration_example -y
```

On a production site you would typically enable only the base module and keep the
example on a development environment.

## Verify it worked

Because Easy Migration is a code framework, there is no admin page to check.
Confirm it is enabled with `drush pml --status=enabled | grep easy_migration`,
then create your first `EasyMigration` plugin class (using
`easy_migration_example` as a template) and run it.
