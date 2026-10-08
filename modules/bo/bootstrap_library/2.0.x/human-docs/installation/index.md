# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Bootstrap framework files themselves**, provided in one of these ways:
  - installed locally under the web root at `/libraries/bootstrap/` (with
    `css/bootstrap[.min].css` and `js/bootstrap[.min].js`), or
  - installed via Composer as `twbs/bootstrap` (the module's *composer* option looks
    under `/libraries/bootstrap/dist/…`), or
  - loaded from a **CDN**, in which case you do not need any local files — you just
    pick a version in the settings form.
- No other contributed Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_library -W
```

The module's own `composer.json` requires `twbs/bootstrap`, so Composer will pull the
Bootstrap library in as well. The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap_library -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

If you prefer not to manage Bootstrap through Composer, download Bootstrap and place
it at `/libraries/bootstrap/` in your web root instead, or plan to use the CDN option.

## Enable the module

```bash
drush en bootstrap_library -y
```

There are **no submodules**. Access to the settings form uses core's *Administer site
configuration* permission, so no extra permission needs granting for administrators.

## Verify it worked

Go to **Configuration → Development → Bootstrap Library**
(`/admin/config/development/bootstrap_library`) — the settings form should load.

Note that immediately after enabling, Bootstrap is **not** attached to any page yet:
the shipped default theme‑visibility rule excludes every theme until you choose one.
Head to [Configuration](../configuration/index.md) to set where Bootstrap loads from
and which themes/pages it applies to, then reload a front‑end page and check the page
source for the Bootstrap CSS/JS.
