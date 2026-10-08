# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Node** module (`node`) enabled — this is the only dependency, and it is
  part of a standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_attributes -y
```

## Verify it worked

Edit any node and open the **Advanced** section of the edit form — you should see
the Page Attributes area for entering a body id/class or article class. Enter a
test value, save, and view the node: the value should appear on the page's markup.
