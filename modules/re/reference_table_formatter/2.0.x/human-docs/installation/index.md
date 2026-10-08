# Installation

## Requirements

Reference Table Formatter needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field UI** module enabled so you can reach the *Manage display* tab
  and select the formatter. There are no other module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reference_table_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reference_table_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reference_table_formatter -y
```

That's all the setup needed. The **Table of Fields** formatter is now available
on the *Manage display* tab for any `entity_reference` or
`entity_reference_revisions` (Paragraphs) field. See the
[overview](../index.md#how-to-use-it) for how to select and configure it.
