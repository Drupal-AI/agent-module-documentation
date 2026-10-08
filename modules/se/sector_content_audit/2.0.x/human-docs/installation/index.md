# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core modules **Datetime**, **Node**, **Taxonomy**, **User**, and **Views**.
- Contrib modules **Default Content** (`default_content`) — used to seed the
  sample taxonomy terms — and **Views Bulk Operations** (`views_bulk_operations`),
  which powers the bulk actions on the audit View.
- **Best with the Sector Starter Kit.** For full behavior the module expects
  components from the Sector distribution — for example the `restricted_basic_html`
  text format (used for the document-notes field via Better Formats) and the
  rabbit-hole term redirects mentioned in the README. It will install without the
  full distribution, but some conveniences depend on it.

Drupal enables the required modules automatically as dependencies when you turn on
Sector Content Audit.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_content_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Default Content,
Views Bulk Operations, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_content_audit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_content_audit -y
```

## What you get on install

Enabling the module provides, ready to use:

- Two vocabularies — **Content audit** (`content_audit`) and **Content
  development** (`content_development`) — pre-seeded with sample terms via Default
  Content.
- Field storages for the audit fields: `field_content_audit`,
  `field_content_development`, `field_audit_date`, `field_review_notes`, and
  `field_document_notes`.
- A **Sector Content Audit** View with exposed filters and Views Bulk Operations.

The audit fields are not yet attached to any content type — you do that per type,
which is covered in [Configuration](../configuration/index.md).
