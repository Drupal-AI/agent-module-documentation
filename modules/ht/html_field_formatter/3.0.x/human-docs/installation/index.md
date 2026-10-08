# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP extensions, or third-party libraries — this is a single,
  dependency-free formatter plugin.

## Install with Composer

From the project root:

```bash
composer require drupal/html_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_field_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_field_formatter -y
```

Once enabled, the **HTML** format becomes available on the **Manage display** tab
for any text or string field. See [How to use it](../index.md#how-to-use-it) on the
overview page — and be sure to read the security note there before applying it.
