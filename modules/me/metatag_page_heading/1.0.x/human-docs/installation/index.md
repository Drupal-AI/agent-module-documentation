# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Metatag** module (`metatag`) — required. Drupal will enable it as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_page_heading -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Metatag if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_page_heading -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_page_heading -y
```

## Verify it worked

After enabling, open a Metatag form (defaults or a per-entity field) and confirm a
**Page Heading** group appears with a **Page heading (h1)** field. Set a value on a
piece of content, then load that page and check that the visible heading reflects
your override while the entity's label is unchanged.
