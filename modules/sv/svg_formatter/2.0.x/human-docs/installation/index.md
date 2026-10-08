# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- The **`enshrined/svg-sanitize`** PHP library (`>=0.22.0`). This is a hard
  Composer requirement of the module, so a normal Composer install pulls it in
  automatically — you do not download it separately. It powers the "sanitize
  inline SVG" option; without it, the sanitize checkbox is disabled.

There are no other module dependencies. (To use the formatter on an **Image**
field rather than a File field, you additionally need the separate
[`svg_image`](https://www.drupal.org/project/svg_image) module.)

## Install with Composer

From the project root:

```bash
composer require drupal/svg_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — here it also brings in `enshrined/svg-sanitize`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_formatter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_formatter -y
```

That is all. There is no configuration form and no permissions to grant. To start
displaying SVGs, add a **File** field (with `svg` in its allowed extensions) and
set its display **Format** to **SVG Formatter** — see the
[main guide](../index.md#how-to-use-it) for the steps.
