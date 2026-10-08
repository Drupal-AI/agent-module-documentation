# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Fundraise Up account** with a Site ID (from your Fundraise Up dashboard).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fundraiseup_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fundraiseup_js -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fundraiseup_js -y
```

## Verify it worked

Go to **Configuration → Web services → Fundraise Up JS**
(`/admin/config/services/fundraiseup-js`) and confirm the settings form loads.
After you enter a Site ID (see [Configuration](../configuration/index.md)), view
any front‑end page and check the page source: the Fundraise Up bootstrap
`<script>` from `cdn.fundraiseup.com` should be present in the `<head>`. The
script does not load on admin pages, and it does not load at all until a Site ID
is configured.
