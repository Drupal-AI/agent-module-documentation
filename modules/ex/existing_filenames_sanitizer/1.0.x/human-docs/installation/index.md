# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Drush 10 or newer** — the module is operated entirely through a Drush command.
- Core's **File** and **System** modules (both part of a standard install; File is
  enabled automatically as a dependency).

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/existing_filenames_sanitizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/existing_filenames_sanitizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en existing_filenames_sanitizer -y
```

## Verify it worked

Confirm the module's Drush command is available:

```bash
drush list --filter=existing_filenames_sanitizer
```

You should see the sanitizer command listed. Before running it against real files,
**take a backup** and use its dry‑run mode to preview the changes — see the "How to
use it" section of the [overview](../index.md).
