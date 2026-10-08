# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

Paragraphs Accordion lists no module dependencies in its metadata and has no
third‑party Composer or PHP library requirements. In practice you will use it
alongside the **Paragraphs** module and a paragraph field to place the accordion
type in.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_accordion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_accordion -y
```

## Verify it worked

Go to **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) — the
accordion paragraph type provided by this module should be listed. Add it to a
paragraph field, enter a few title/text pairs on a piece of content, and confirm the
saved content renders as a collapsible accordion.
