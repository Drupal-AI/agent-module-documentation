# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- Drupal core only for the analysis itself — there are no required contrib
  dependencies.
- Optional: the **[Metatag](https://www.drupal.org/project/metatag)** module. If it is
  installed, the snippet preview's title and meta description come from your
  Metatag-configured values; otherwise the title falls back to the entity label and the
  description is left empty.

> **Composer namespace.** This project is published under the `swisnl/` vendor
> namespace, not `drupal/` — use the require command below exactly as written.

## Install with Composer

From the project root:

```bash
composer require swisnl/yoast_analysis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require swisnl/yoast_analysis -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en yoast_analysis -y
```

There are no submodules and no settings page. To make the SEO Analysis tab appear, you
enable the `yoast_analysis` view mode on the bundles you want — see
[Configuration](../configuration/index.md).
