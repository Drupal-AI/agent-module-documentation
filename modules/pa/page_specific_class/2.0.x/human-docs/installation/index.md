# Installation

## Requirements

Page Specific Class is a small theming helper with no external dependencies. It
needs:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and it depends on no
other contributed modules.

## Install with Composer

From the project root:

```bash
composer require drupal/page_specific_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_specific_class -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_specific_class -y
```

That's all it takes. Nothing changes on the site until you add at least one
`path|class` rule — see [Configuration](../configuration/index.md).
