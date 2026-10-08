# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Media** and **File** functionality (you need file media entities for the
  formatters to apply to).

There are no third-party Composer or PHP library requirements. The optional
"open in a new window" behaviour requires a core patch — see the
[overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/mff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mff -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mff -y
```

## Verify it worked

Go to the **Manage display** of an entity or view mode that renders a file media
field and confirm the new Media File Formatters options appear in the field's format
selector. Choose one, save, and view the rendered output to confirm the link text or
description renders as expected.
