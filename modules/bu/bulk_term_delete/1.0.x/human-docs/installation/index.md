# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — this is the only dependency,
  and Drupal enables it automatically as a dependency if it isn't already on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_term_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulk_term_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_term_delete -y
```

That's all it takes. The bulk-delete capability now appears on the taxonomy term
overview page for each vocabulary. There is no configuration to do — who can use
it is governed by your existing taxonomy administration permissions.
