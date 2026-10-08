# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush 12 or newer** — the module is entirely Drush-based.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fs_cli -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fs_cli -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fs_cli -y
```

No configuration is required.

## Verify it worked

Run a harmless existence check — for example:

```bash
drush fs:file-exists public://
```

If the command runs and returns JSON, the module is installed and its Drush commands
are available. See the [main guide](../index.md) for the full command list and
examples.
