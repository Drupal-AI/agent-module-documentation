# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 | ^11`
  — note the single pipe before `^11` is an upstream typo; it still parses).
- No other modules, PHP extensions, or third‑party libraries are required.

**Before you install:** confirm this is the right tool. If your site runs any
third‑party tracking, you need a full consent manager, not this notice‑only block
(see the [overview](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/consent_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consent_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consent_popup -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm a
**Consent Popup** block is now available to place. Placing and configuring that
block is the whole setup — see [Configuration](../configuration/index.md).
