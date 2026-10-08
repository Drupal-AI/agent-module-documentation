# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`) — required. This is a contrib
  module, so Composer pulls it in for you if it isn't already present. (Paragraphs
  in turn brings in Entity Reference Revisions.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/default_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required **Paragraphs** module if
you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/default_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_paragraphs -y
```

This enables Paragraphs as a dependency if it isn't already on. There is no settings
form — select the **Default paragraphs widget** on a field's form display, as
described in the [overview](../index.md#how-to-use-it).

There are no submodules.
