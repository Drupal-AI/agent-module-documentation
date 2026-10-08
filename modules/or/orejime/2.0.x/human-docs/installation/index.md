# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **Field**, **Media**, **User**, **System**, and **Views** modules —
  all part of Drupal core and enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements. By default the
Orejime JavaScript and CSS are loaded from the public unpkg CDN; you can point
them at a self-hosted copy from the settings form later if your site must avoid
external requests.

## Install with Composer

From the project root:

```bash
composer require drupal/orejime -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/orejime -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orejime -y
```

There are no submodules to consider.

## Next steps

Enabling the module does not show a banner on its own — you need at least one
published consent service and a filled-in settings form. Head to
[Configuration](../configuration/index.md) to create your first consent service,
set the privacy-policy link, and decide how the banner behaves.
