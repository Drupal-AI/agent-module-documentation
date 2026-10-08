# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — enabled on most sites already; pulled in as a
  dependency.
- The **jQuery DataTables JavaScript library** at runtime — hosted locally in
  `/libraries`, or loaded from a CDN (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/datatables -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datatables -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datatables -y
```

## Install the DataTables JavaScript library

The module ships the Drupal glue, not the DataTables library itself. Choose one of:

- **Local (recommended for offline / controlled environments).** Install the library
  into your site's `/libraries` folder, for example via Asset Packagist:

  ```bash
  composer require npm-asset/datatables.net-dt:^2.3.8
  ```

  with an `installer-paths` entry mapping it into `web/libraries/datatables`. Then
  leave the **Use CDN** setting off.

- **CDN.** Turn the **Use CDN** setting on and the module loads the library from
  `cdn.datatables.net` instead — no local files needed.

After installing locally, check **Reports → Status report** — the module reports
whether the DataTables assets were found and the version is compatible. See
[Configuration](../configuration/index.md) for the Use CDN toggle.
