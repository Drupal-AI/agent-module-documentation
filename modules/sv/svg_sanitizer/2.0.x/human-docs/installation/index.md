# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`enshrined/svg-sanitize`** PHP library (version `~0.13`) — the actual
  sanitizer. Because it's a Composer library rather than a Drupal module,
  installing this module via Composer pulls it in automatically.

There are no Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_sanitizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies, including the `enshrined/svg-sanitize` library. Installing with
Composer (rather than downloading the module manually) is important here, since it
is what brings in the library the module depends on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_sanitizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_sanitizer -y
```

There is nothing to configure globally. Once enabled, the **SVG Sanitizer**
formatter is available on your SVG‑bearing fields — see
[Configuration](../configuration/index.md) for how to apply it.
