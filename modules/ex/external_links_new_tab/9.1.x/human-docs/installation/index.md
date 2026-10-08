# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No module dependencies, no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/external_links_new_tab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_links_new_tab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_links_new_tab -y
```

That is all it takes. There is no configuration — external links begin opening in a
new tab (with `rel="noopener"`) immediately.
