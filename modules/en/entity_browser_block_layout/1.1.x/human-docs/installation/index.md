# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No hard module dependencies are declared, but the module only does anything useful
  on a site that uses **Entity Browser** blocks together with core **Layout
  Builder** — that combination is the whole point of the module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_block_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_browser_block_layout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser_block_layout -y
```

## Verify it worked

There is no settings page and no required setup. To confirm the improvements are
active, open the Layout Builder UI on a site that uses Entity Browser blocks and add
or manage one of those blocks — the placement experience should feel smoother, with
the module's UX and CSS adjustments applied.
