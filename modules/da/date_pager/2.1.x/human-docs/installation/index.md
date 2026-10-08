# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — enabled by default on most sites.
- No third‑party Composer or PHP library requirements. (The module has a test‑only
  relationship with **Smart Date**, so it is expected to work with Smart Date
  fields as well as core's `datetime`, `daterange`, `changed`, and `created`
  fields, but Smart Date is not required.)

## Install with Composer

From the project root:

```bash
composer require drupal/date_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_pager -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_pager -y
```

## Verify it worked

Edit a View and open its **Pager** section. When you go to change the pager type,
**Date pager** should now appear as an option alongside the core pagers. Select it,
configure the date field and granularity (see
["How to use it"](../index.md#how-to-use-it)), and save. Load the view's page — the
pager links should step through time periods, and the URL should carry the current
period. On a large content set, make sure the date field is indexed for good
performance.
