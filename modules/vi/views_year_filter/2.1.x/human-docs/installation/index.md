# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and normally already
  enabled.

There are no third‑party Composer or PHP library requirements. A few modules are
optional companions: **Search API** enables the year filter on Search API date fields,
**Date Popup** upgrades non‑year date filters to HTML5 date pickers, and **Smart Date**
fields are deliberately left on their own year granularity.

## Install with Composer

From the project root:

```bash
composer require drupal/views_year_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_year_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_year_filter -y
```

The module ships no submodules. Once enabled, the extra **A date in CCYY format.** value
type appears on your date filters inside the Views UI — see
[Configuration](../configuration/index.md) for how to use it.
