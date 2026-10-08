# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- No other modules are required — it depends only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/sticky_local_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky_local_tasks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sticky_local_tasks -y
```

## Verify it worked

Log in as an administrator and open a content edit page (or any page that shows
local task tabs). You should see a sticky control — by default a small icon in a
corner of the screen — that holds the *View / Edit / Revisions / Delete* tabs and
stays visible as you scroll. To change its position or behaviour, see
[Configuration](../configuration/index.md).
