# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Config Pages](https://www.drupal.org/project/config_pages)** module
  (`config_pages`) — this is a hard dependency. Install and enable it first (or let
  Composer/Drush pull it in), and create at least one Config Pages type with fields.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_pages_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Config Pages dependency
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_pages_viewer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_pages_viewer -y
```

Drupal will enable **Config Pages** at the same time if it is not already on.

## Verify it worked

Visit `/config_pages_viewer/{config_page_type}`, replacing `{config_page_type}` with the
machine name of one of your Config Pages types. If the page renders that config page's field
values, the module is working. If you have not created a Config Pages type yet, do that
first under **Structure → Config pages types**.

The route is gated by the Config Pages `view` permission — see
[the main guide](../index.md) under "How access works" for which permission controls each
page and where to grant it.
