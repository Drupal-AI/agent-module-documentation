# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 | ^10`).
- No module dependencies beyond Drupal core, and no third-party Composer or PHP
  library requirements.
- Most useful on a site with more than one language configured, though it also
  works on single-language sites.

## Install with Composer

From the project root:

```bash
composer require drupal/alter_hreflang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alter_hreflang -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alter_hreflang -y
```

Once enabled, set your per-language override codes at
**`/admin/config/regional/alter-hreflang`** — see
[How to use it](../index.md#how-to-use-it).
