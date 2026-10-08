# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Field** and **Node**.
- **Metatag** (`metatag`), **Redirect** (`redirect`) and **Redirect 404**
  (`redirect_404`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_seo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Metatag, Redirect
and Drutopia Core.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_seo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_seo -y
```

This imports the shared `field_meta_tags` field storage and enables the Metatag,
Redirect and Redirect 404 dependencies that provide the actual SEO behaviour.

## Verify it worked

Confirm the Metatag admin page is available at **Configuration → Search and
metadata → Metatag** (`/admin/config/search/metatag`) and URL redirects at
**Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`). As you enable other Drutopia content features,
their content types should gain a meta tags field automatically.
