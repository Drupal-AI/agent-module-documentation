# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is part of Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/exposed_filter_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exposed_filter_data -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exposed_filter_data -y
```

## Verify it worked

Open a View that has an exposed filter in the **Views UI** (**Structure → Views**)
and add the module's exposed-filter output to the View's **Header**. Save, then
view the page and apply a filter — the active filter value(s) should now appear in
the header.

Next, see the "How to use it" section of the [overview](../index.md) for theming
the output.
