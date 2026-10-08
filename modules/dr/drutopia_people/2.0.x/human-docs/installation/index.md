# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`) and
  [**Drutopia SEO**](../../../drutopia_seo/2.0.x/human-docs/index.md)
  (`drutopia_seo`).
- **Display Suite** (`ds`), **Field Group** (`field_group`), **Paragraphs**
  (`paragraphs`), **Pathauto** (`pathauto`), **Metatag** (`metatag`),
  **Search API** (`search_api`) and **Views Plain** (`views_plain`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_people -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Drutopia and
supporting projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_people -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_people -y
```

This imports the `people` content type, its fields and displays, the
`people_type` vocabulary, the people listing and content-by-author views, the
Pathauto pattern and the Metatag/SEO and search configuration. An update hook
enables the Views Plain dependency.

## Verify it worked

Visit **Structure → Content types** (`/admin/structure/types`) and confirm the
**People** type is listed. Open its listing view and confirm the "Add person"
action link appears; adding a profile (`/node/add/people`) should show the
position, type, image and body fields.
