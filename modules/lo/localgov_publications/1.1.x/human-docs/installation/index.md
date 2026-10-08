# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Book** module as a **contributed project** — Book left Drupal core after
  Drupal 10, so a Drupal 11 site must install `drupal/book` explicitly. This
  module's `composer.json` requires it (`drupal/book ^1.0.0`), so Composer pulls it
  in for you.
- **Pathauto** (`drupal/pathauto`) for chapter URLs.
- **LocalGov Core / Media** (`localgov_core`, `localgov_media`) and **LocalGov
  Paragraphs** (`localgov_paragraphs ^2.4`) for chapter content.
- Core **Block**, **Menu UI**, **Text** and **Views**.
- A **LocalGov Drupal** site — the module expects the distribution's configuration
  (for example the `wysiwyg` text format) to be present. On bare Drupal core,
  enabling it can fail with an unmet config dependency, so install it as part of a
  LocalGov site.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_publications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the contrib **Book**
module, Pathauto and the LocalGov dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_publications -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_publications -y
```

Drupal enables Book, Pathauto and the LocalGov dependencies at the same time.

## After enabling

Grant the **access publication views** permission to your editorial roles at
**People → Permissions** (`/admin/people/permissions`) so they can see the
publication listings. Reordering a publication's chapters additionally needs the
core **Administer book outlines** permission.

## Verify it worked

Go to **Content → Add content**. You should see **Publication page** (and
**Publication cover page**). Create a couple of Publication pages, nest one under the
other, and view the parent — you should see chapter navigation and a contents
listing generated from the hierarchy.
