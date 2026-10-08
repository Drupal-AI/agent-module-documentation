# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`).
- Core's **Views** module (`views`), which powers the Paragraph Lineage listing.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_lineage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed. (Views is part of Drupal core.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_lineage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_lineage -y
```

Make sure the **Views** module is enabled too (it is in core and usually already
on). Paragraphs must be installed and enabled as well.

## Verify it worked

Go to **Content → Paragraph Lineage** (`/admin/content/paragraph-lineage`). The
View should load and list paragraph entities, each with links to view it as a
*teaser*, *preview* or *default*. If that page appears, the module is installed
correctly.
