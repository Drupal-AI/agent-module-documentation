# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Facets** module (`drupal/facets`) — this module provides processors for it
  and cannot work without it. Composer pulls it in with the command below.

There are no third‑party PHP library requirements. This project **is covered by
Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_link_field_processors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_link_field_processors -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_link_field_processors -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Edit a facet built on a **Link** field at **Configuration → Search and metadata →
Facets** (`/admin/config/search/facets`) and confirm the
**TranslateEntityInLinkProcessor** processor is available to enable in the facet's
processor list. Enable it, save, and check the facet now shows entity labels rather
than URIs.
