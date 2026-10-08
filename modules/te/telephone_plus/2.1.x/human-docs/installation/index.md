# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) and **Telephone** module (`telephone`) — both
  are declared dependencies and Drupal enables them automatically.
- The **2.1.x** series adds support for **PHP 8.4+** (its features otherwise match
  2.0.x). There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telephone_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_plus -y
```

## Verify it worked

Go to a content type's **Manage fields** screen and add a field. The **Telephone
Plus** field type should appear in the list. Add it, then on **Manage form display**
you should be able to expose the title, extension, and supplementary‑info parts, and
on **Manage display** you should see the **Plain text** and **Link text** (`tel:`)
formatters.
