# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Paragraphs** module (`paragraphs`) — a hard dependency, enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_tabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_tabs -y
```

Drupal will enable Paragraphs automatically if it is not already on.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then edit a piece
of content with a Paragraphs field and check that you can add the tabs paragraph
and pick a horizontal or vertical layout for it.
