# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** and **Taxonomy** modules enabled (both ship with Drupal core).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_taxonomy_term_name_into_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_taxonomy_term_name_into_id -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_taxonomy_term_name_into_id -y
```

There are no submodules and nothing to configure at the site level. The new
**Taxonomy term name as ID** validator becomes available immediately inside the
Views UI.

## Verify it worked

Edit any View with a "Has taxonomy term ID" contextual filter, tick **Specify
validation criteria**, and open the **Validator** drop-down — you should see
**Taxonomy term name as ID** listed. See the [overview](../index.md#how-to-use-it)
for the full walk-through.
