# Installation

## Requirements

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Path** module (`path`).
- The contributed **CTools** module (`drupal/ctools`) — supplies the condition
  plugins used for a pattern's bundle/language selection criteria.
- The contributed **Token** module (`drupal/token`).

All three dependencies are enabled automatically when you turn on View mode page.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/view_mode_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in CTools and Token
at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/view_mode_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_mode_page -y
```

Enabling it also enables Path, CTools, and Token if they are not already on. The
module ships no submodules.

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
View mode page** (`/admin/config/search/view-mode-page`). You should see the
(initially empty) list of patterns, with a button to add one. See
[Configuration](../configuration/index.md) for how to create a pattern.
