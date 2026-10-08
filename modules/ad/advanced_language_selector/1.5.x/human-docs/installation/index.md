# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **multilingual** site — the block is only visible when Drupal reports more than
  one language, so you'll want core's **Language** module (and typically **Interface
  Translation** / **Content Translation**) configured with at least two languages.
- No module dependencies of its own.

There are no third‑party Composer or PHP library requirements. The Bootstrap
display styles can optionally pull Bootstrap 5 and Popper from a CDN, but only if
you enable that option (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_language_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_language_selector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_language_selector -y
```

Once enabled, place the block and choose a style — see
[Configuration](../configuration/index.md). Remember the block stays hidden until
your site has more than one language.

There are no submodules.
