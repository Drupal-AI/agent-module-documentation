# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — this is the only dependency, and Drupal
  enables it automatically (Filter is part of the standard install anyway).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/collapse_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/collapse_text -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en collapse_text -y
```

Or enable **Collapse Text** from **Extend** (`/admin/modules`).

Enabling the module does **not** activate the filter anywhere on its own — you
must turn on the *Collapsible text blocks* filter for each text format that
should support the `[collapse]` syntax. See
[Configuration](../configuration/index.md) for that step, which also covers the
important filter‑ordering rules.

There are no submodules.
