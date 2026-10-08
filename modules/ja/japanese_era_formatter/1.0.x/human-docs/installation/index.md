# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Datetime** module (`datetime`) — this is the only dependency, and it
  provides the datetime fields this formatter renders. Drupal enables it
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/japanese_era_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/japanese_era_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en japanese_era_formatter -y
```

## Verify it worked

Go to the **Manage display** page of any entity that has a datetime field (for
example **Structure → Content types → Article → Manage display**). In the
**Format** dropdown for that field you should now see **Japanese Era Date
Format** as an option. Select it and view a piece of content to confirm the date
renders in Japanese era notation. The full walkthrough is in the "How to use it"
section of the [guide index](../index.md).
