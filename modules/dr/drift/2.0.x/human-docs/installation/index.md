# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Drift.com account** — the widget won't do anything until it's keyed to your
  Drift account.

There are no module dependencies or third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drift -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drift -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drift -y
```

## Verify it worked

1. Go to the Drift settings form under **Configuration** (route `drift.config`)
   and confirm it loads.
2. Enter your Drift account identifier and enable the widget (see
   [Configuration](../configuration/index.md)).
3. Load a front‑end page as a visitor — the Drift chat widget should appear once
   the account identifier is set.
