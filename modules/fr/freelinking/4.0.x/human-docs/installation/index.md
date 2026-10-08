# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`) — this is the only dependency and is enabled on
  essentially every Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/freelinking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/freelinking -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en freelinking -y
```

Enabling the module makes the filter *available*; nothing happens to your content
until you switch the filter on for a text format — see
[Configuration](../configuration/index.md).

## Submodules

- **Freelinking Prepopulate** (`freelinking_prepopulate`) — provides a prepopulated
  "create content" link, so a link to a node that doesn't exist yet can point to a
  content‑creation form with values pre‑filled. It requires the separate
  [Prepopulate](https://www.drupal.org/project/prepopulate) module. Enable it only if
  you need that behaviour:

  ```bash
  drush en freelinking_prepopulate -y
  ```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a format, and confirm that **Freelinking**
appears in the list of available filters. Then follow
[Configuration](../configuration/index.md) to enable it and choose your options.
