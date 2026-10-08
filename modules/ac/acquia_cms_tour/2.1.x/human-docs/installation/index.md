# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Common** (`acquia_cms_common`) — Drupal enables it automatically as
  a dependency. This module is meant for an Acquia CMS site and assumes the rest of
  the distribution is present.

There are no extra Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_tour -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Acquia CMS Common
and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cms_tour -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_tour -y
```

Once enabled, open the tour dashboard from the **Acquia CMS** section of the admin
and work through the setup steps — see [Configuration](../configuration/index.md).
