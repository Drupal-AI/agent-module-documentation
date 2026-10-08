# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **JSON:API** module (`jsonapi`) — Better Json Response depends on it, and
  Drupal enables it automatically as a dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_json_response -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_json_response -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_json_response -y
```

Enabling this also enables core JSON:API if it was not already on. There is no
configuration — the improved response class is now available for use in custom
code (see [How to use it](../index.md#how-to-use-it)).
