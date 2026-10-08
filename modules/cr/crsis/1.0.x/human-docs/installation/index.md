# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Node** module (`node`) — required for accessing and analyzing node
  content, and enabled automatically as a dependency.

No contributed modules, external libraries, or third-party APIs are needed — the
Flesch-Kincaid calculation runs entirely in PHP on your site.

## Install with Composer

From the project root:

```bash
composer require drupal/crsis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crsis -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crsis -y
```

## Verify it worked

Log in as an administrator, go to **Configuration → Content authoring → CRSIS
Settings** (`/admin/config/content/crsis`) to enable analysis and set a minimum
score, then open **Content → CRSIS Dashboard** (`/admin/content/crsis-dashboard`).
You should see your published content listed with readability scores. See
[Configuration](../configuration/index.md).
