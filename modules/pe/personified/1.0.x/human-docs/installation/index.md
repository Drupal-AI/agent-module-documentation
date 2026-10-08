# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **JS Cookie** (`js_cookie`) and **JSON Template** (`json_template`)
  modules — both are dependencies. Composer pulls them in when you require
  Personified.
- No third‑party PHP libraries are required.

You also need the groundwork described in the [overview](../index.md#how-to-set-it-up):
client‑side variables available in the browser and a JSON endpoint (for example a
View with a JSON output) that returns content filtered by parameters.

## Install with Composer

From the project root:

```bash
composer require drupal/personified -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches the required JS Cookie and JSON Template
modules for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/personified -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en personified -y
```

Enabling this module also enables JS Cookie and JSON Template if they are not
already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
**Personified** block is available to place. After you configure a block against
your JSON endpoint (see the [overview](../index.md#how-to-set-it-up)), load a page
where it appears and check that it fetches and renders the personalized content.
If it shows stale data, clear the Drupal, Varnish, and OPcache caches.
