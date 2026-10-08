# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules are required, and there are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_import_de -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_import_de -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_import_de -y
```

## Verify it worked

With the module enabled, run a configuration import that would delete a
content-bearing config item (a content type or field) — ideally in a safe
environment first. Use the module's **debug/listing** behaviour to confirm it
reports the affected entities as type/id pairs, and that a normal import then
completes instead of being blocked. Always back up before testing this against real
content.
