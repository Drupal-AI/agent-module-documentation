# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

The module lists no hard module dependencies, but it is a Paragraphs field
formatter, so it is only useful on a site running the **Paragraphs** module with
at least one Paragraphs field. There are no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_wrap_by_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_wrap_by_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_wrap_by_field -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then open a
content type's **Manage display** and check that the wrap‑by‑field formatter is
available in the **Format** column for your Paragraphs field.
