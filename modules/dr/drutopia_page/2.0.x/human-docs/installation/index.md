# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Node**.
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`) and
  [**Drutopia SEO**](../../../drutopia_seo/2.0.x/human-docs/index.md)
  (`drutopia_seo`).
- **Display Suite** (`ds`), **Entity Reference Revisions**
  (`entity_reference_revisions`), **Metatag** (`metatag`), **Paragraphs**
  (`paragraphs`), **Pathauto** (`pathauto`) and **Token** (`token`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Drutopia and
supporting projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_page -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_page -y
```

This imports the `page` content type, its fields, displays, RDF mapping and
Pathauto pattern, and grants page create and edit permissions to the Drutopia
contributor (own pages), editor and manager (any page) roles.

## Verify it worked

Visit **Structure → Content types** (`/admin/structure/types`) and confirm the
**Page** type is listed. Adding a page (`/node/add/page`) should show the body,
summary, paragraph and meta tags fields. Check **People → Permissions**
(`/admin/people/permissions`) to confirm the editorial roles can create and edit
pages.
