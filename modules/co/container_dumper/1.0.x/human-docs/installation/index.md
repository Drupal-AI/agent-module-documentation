# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.2 or higher**.
- Core's **System** module (8.5+) — always present on a Drupal site.

There are no additional PHP libraries or third‑party Composer requirements. This
project is covered by Drupal's security advisory policy. Because the dumped file can
expose your whole service container, this is best used in **development and CI
environments**, not production.

## Install with Composer

From the project root:

```bash
composer require drupal/container_dumper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/container_dumper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en container_dumper -y
```

## Verify it worked

Nothing is written until you set a dump path. Go to
[Configuration](../configuration/index.md), set a **non‑web‑accessible** path, save,
then rebuild caches (`drush cr`). Confirm the XML file appears at the path you chose
and that the path sits outside your webroot.
