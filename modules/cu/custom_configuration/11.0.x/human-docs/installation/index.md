# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP requirements.

For per‑domain values to be meaningful you'll typically pair this with a
multi‑domain setup, and for per‑language values with core's multilingual modules —
but neither is a hard dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_configuration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_configuration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_configuration -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Custom
Configuration**. You should see the configuration list, ready for you to add your
first entry. See [Configuration](../configuration/index.md) for how to create and
manage entries.
