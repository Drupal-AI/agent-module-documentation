# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`)
  — the only dependency. (Filtering of reference widgets applies to node
  Entity Reference Revisions Paragraphs fields.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_filter -y
```

## Verify it worked

Go to **Structure → Paragraph types** (`/admin/structure/paragraphs_type`) and edit
any paragraph type — you should see a new **Content types** checkboxes element on
its edit form. Select a content type or two, save, and confirm the paragraph types
list now offers a filter you can use to narrow it by content type. On a node whose
Paragraphs field references that content type, the offered paragraph types should be
restricted accordingly.
