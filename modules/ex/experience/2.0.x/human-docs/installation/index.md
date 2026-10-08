# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), part of a standard Drupal install and enabled
  automatically as a dependency.
- Core's **Views** module if you want to use the module's Experience filter in
  listings (Views ships with Drupal core).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/experience -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/experience -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en experience -y
```

## Verify it worked

Go to a bundle's **Manage fields** page (for example **Structure → Content types →
Article → Manage fields**), click **Add field**, and confirm **Experience** appears
in the field‑type list. Add it, then create content of that type — you should see
the year/month select lists (and the "Fresher" option if you enabled it) on the
form, and the value rendered as "X Year(s) Y Month(s)" on display. See the "How to
use it" section of the [overview](../index.md) for configuring the year range,
labels, and formatters.
