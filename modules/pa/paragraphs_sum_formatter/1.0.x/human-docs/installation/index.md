# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Paragraphs** module (`paragraphs`) — a hard dependency, enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_sum_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_sum_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_sum_formatter -y
```

Drupal will enable Paragraphs automatically if it is not already on.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then open a
content type's **Manage display** and check that **Paragraphs Sum formatter**
appears as an option in the **Format** column for your multi‑value Paragraphs
field.
