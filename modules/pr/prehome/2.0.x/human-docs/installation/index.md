# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no dependent
modules.

> **Upgrading from 1.x?** The 1.x branch supports only Drupal 8/9 and is no longer
> maintained. Use the 2.x version (this one) on Drupal 9/10/11.

## Install with Composer

From the project root:

```bash
composer require drupal/prehome -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prehome -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prehome -y
```

## A note for GDPR/cookie-consent sites

Prehome tracks how often a visitor has seen the splash using a cookie named
`prehome_display_count`. If you run a GDPR or cookie-consent module, add
`prehome_display_count` to its list of allowed cookies so the display count works
as expected.

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to set up the
prehome entity, author at least one prehome item, and configure its display. Once
a prehome exists and is configured to show, visiting the site should present it
before the homepage.
