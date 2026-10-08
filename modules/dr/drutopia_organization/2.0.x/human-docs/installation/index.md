# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`),
  [**Drutopia Event**](../../../drutopia_event/2.0.x/human-docs/index.md)
  (`drutopia_event`) and
  [**Drutopia SEO**](../../../drutopia_seo/2.0.x/human-docs/index.md)
  (`drutopia_seo`).
- **Paragraphs** (`paragraphs`), **Inline Entity Form** (`inline_entity_form`),
  **Facets** (`facets`), **Focal Point** (`focal_point`), **Field Group**
  (`field_group`), **Display Suite** (`ds`), **Pathauto** (`pathauto`) and
  **Metatag** (`metatag`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

> **Note:** This project is marked *not covered* by Drupal's security-advisory
> policy and is in *maintenance fixes only* status. Review it before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_organization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Drutopia and
supporting projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_organization -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_organization -y
```

This imports the `organization` content type, its fields, displays, field
groups, facets, Pathauto pattern and the "Add organization" action link.

## Verify it worked

Visit **Structure → Content types** (`/admin/structure/types`) and confirm the
**Organization** type is listed, then open its listing view and confirm the "Add
organization" action link appears. Adding an organization
(`/node/add/organization`) should show the image and paragraph body fields.
