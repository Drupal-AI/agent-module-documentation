# Installation

## Requirements

- **Drupal 8.7.7 through 12** (`core_version_requirement: ^8.7.7||^9||^10||^11||^12`).
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/expandable_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expandable_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expandable_formatter -y
```

## Verify it worked

Go to a content type's **Manage display** (for example **Structure → Content types
→ Article → Manage display**) and open the **Format** dropdown for a text field
such as **Body**. You should see **Expandable** as an option. Select it, configure
a collapsed height, save, then view a node with a long body — it should appear
trimmed to that height with a "read more" toggle that expands it. See the "How to
use it" section of the [overview](../index.md) for the available options.
