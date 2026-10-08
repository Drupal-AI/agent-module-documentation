# Installation

## Requirements

GovCMS DLM is lightweight and has no third‑party dependencies. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other contrib modules and no PHP library requirements — it hooks into
  Drupal's core mail system.

The module is primarily intended for Australian Government (GovCMS) sites that
must apply email protective markings, but it works on any Drupal 10/11 site.

## Install with Composer

From the project root:

```bash
composer require drupal/govcms_dlm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govcms_dlm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en govcms_dlm -y
```

## Verify it worked

After enabling, open the module's settings and set your default protective
marking (see [Configuration](../configuration/index.md)). Then trigger a test
email from your site — for example a password‑reset request — and confirm the
subject line now ends with the marking you chose, e.g. `… [SEC=OFFICIAL]`.
