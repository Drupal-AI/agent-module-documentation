# Installation

> **Reminder:** this module is **deprecated**. Install it only to keep an
> existing site running; for new sites use
> [Drutopia Page](../../../drutopia_page/2.0.x/human-docs/index.md).

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Field**, **Menu UI**, **Node**, **Path** and **User**.
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`) and
  [**Drutopia SEO**](../../../drutopia_seo/2.0.x/human-docs/index.md)
  (`drutopia_seo`).
- **Display Suite** (`ds`), **Entity Reference Revisions**
  (`entity_reference_revisions`), **Exclude Node Title** (`exclude_node_title`),
  **Metatag** (`metatag`), **Paragraphs** (`paragraphs`) and **Pathauto**
  (`pathauto`).

No third-party PHP-library requirements; Composer fetches the Drupal projects.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_landing_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Drutopia and
supporting projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_landing_page -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_landing_page -y
```

This imports the `landing_page` content type and its fields, displays, meta tags
field and Pathauto pattern.

## Verify it worked

Visit **Structure → Content types** (`/admin/structure/types`) and confirm the
**Landing Page** type is listed, then try **Content → Add content → Landing
Page** (`/node/add/landing_page`) — the form should show the paragraph body and
meta tags fields.
