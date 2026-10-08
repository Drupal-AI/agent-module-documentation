# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Editor**/CKEditor if you want to use the optional `target` filter in
  the rich‑text editor (the automatic external‑link handling needs nothing
  beyond core).
- Recommended: the base **DSFR for Drupal** theme, since this module is part of
  the DSFR for Drupal suite and is meant to be used with it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr4drupal_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr4drupal_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dsfr4drupal_links -y
```

External‑link handling takes effect immediately — there is nothing further to
configure for it.

## Verify it worked

View a page that contains a link pointing to another site and inspect the
markup: the link should now carry `target="_blank"` and `rel="noopener
external"`. To use the optional editor control, enable this module's link/target
filter on a CKEditor text format at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`), as described in the
["How to use it"](../index.md#how-to-use-it) section.
