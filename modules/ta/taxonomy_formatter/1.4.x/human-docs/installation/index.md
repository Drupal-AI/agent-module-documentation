# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — Drupal enables it automatically as a
  dependency when you turn on Taxonomy Formatter.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_formatter -y
```

That's all. There is no configuration page — the new **Taxonomy Formatter** option
now appears in the **Format** dropdown for term-reference fields on any entity's
**Manage display** tab. See the [main page](../index.md#how-to-use-it) for how to
select and configure it.
