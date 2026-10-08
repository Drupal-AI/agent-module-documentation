# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Filter** module, which is part of a standard install.

There are no dependencies beyond Drupal core and no special PHP requirements. The **Tablesaw**
JavaScript/CSS library is bundled with the module, so there is nothing extra to download.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_tables_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/responsive_tables_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_tables_filter -y
```

There are no submodules.

## After enabling

Nothing is responsive yet — you must switch the filter on for the text formats you want, or
turn on the site‑wide Views/theme option. Continue to
[Configuration](../configuration/index.md).
