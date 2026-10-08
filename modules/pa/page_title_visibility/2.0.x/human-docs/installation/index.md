# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Block**, **Node**, and **System** modules (all part of core; enabled
  automatically as dependencies).
- Your content type(s) must render a **page-title block** for the hiding to have any
  visible effect. In most themes the Page Title block is placed by default.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_title_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_title_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_title_visibility -y
```

On install the module adds the **Display page title** field to every node and
backfills it to *visible* (`1`) for all existing published nodes and revisions, so
enabling it changes nothing about how your current content looks. It also sets its
own module weight to run late (after modules such as Scheduler).

To grant editors control, assign the **Administer page display visibility config**
permission to the appropriate roles at **People → Permissions**, then see
[Configuration](../configuration/index.md).
