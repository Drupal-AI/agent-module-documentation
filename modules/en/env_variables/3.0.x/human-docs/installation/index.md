# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: ">=8"`).
- The **`vlucas/phpdotenv`** PHP library (`^5.0`), which reads the `.env` file.
  Because of this Composer dependency you **must install the module with Composer**
  (not by copying files) so the library is pulled in.

## Install with Composer

From the project root:

```bash
composer require drupal/env_variables
```

Composer installs `vlucas/phpdotenv` alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/env_variables`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en env_variables -y
```

## Verify it worked

Go to **Administration → Configuration → Environment Settings**. You should see
the settings form where you configure the `.env` file path. See
[Configuration](../configuration/index.md) for details, including how to point at
your `.env` file and which roles may reach the list page.
