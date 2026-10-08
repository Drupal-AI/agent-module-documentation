# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`) enabled — this is the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_collapsible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_collapsible -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_collapsible -y
```

That is the entire setup — there is no configuration step. The collapsible
controls appear immediately on any edit form whose Paragraphs field uses the
classic (`entity_reference_paragraphs`) widget.

## Verify it worked

Edit a piece of content that has a classic Paragraphs field with a few items.
Each paragraph row with a title should show a `[+]` / `[-]` toggle, and the field
label should show an **Expand all / Collapse all** button.
