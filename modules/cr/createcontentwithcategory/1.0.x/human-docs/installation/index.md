# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Prepopulate** module (`prepopulate`), which seeds the reference field's value
  from the link URL. It is installed automatically as a dependency.
- A content type with an **entity-reference (taxonomy term) field**, and a vocabulary
  with terms — this is what the creation links are built from.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/createcontentwithcategory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Prepopulate and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/createcontentwithcategory -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en createcontentwithcategory -y
```

Prepopulate is enabled at the same time.

## Verify it worked

1. Confirm the module and Prepopulate appear at **Extend** (`/admin/modules`).
2. Visit the settings page at **Configuration → Content authoring → Create Content with
   Category** (`/admin/config/content/createcontentwithcategory`).
3. Continue to [Configuration](../configuration/index.md) to choose a content-type/field
   combination and place the resulting block.
