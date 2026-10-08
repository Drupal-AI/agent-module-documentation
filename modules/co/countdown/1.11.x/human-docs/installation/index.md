# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Block** module (`block`) — the only dependency, which Drupal enables
  automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/countdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/countdown -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en countdown -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm a
**Countdown** block is available to place. Once you place and configure one (see
[Configuration](../configuration/index.md)), it should show a live ticking timer on
the frontend.
