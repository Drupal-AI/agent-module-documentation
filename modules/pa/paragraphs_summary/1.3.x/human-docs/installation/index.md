# Installation

## Requirements

- **Drupal 8 through 12** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`) — this is what provides the Paragraphs fields the formatter works on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_summary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_summary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_summary -y
```

There are no submodules and no settings page. Once enabled, the **Paragraphs enhanced
summary** formatter is available to pick on any Paragraphs field's **Manage display**
tab — see the [overview](../index.md#how-to-use-it).
