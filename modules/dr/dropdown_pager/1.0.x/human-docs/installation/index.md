# Installation

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`), which ships with Drupal.

There are no additional dependencies or third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dropdown_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropdown_pager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropdown_pager -y
```

Make sure core's Views module is enabled (it usually is); Drupal will require it as
a dependency.

## Verify it worked

1. Go to **Structure → Views** (`/admin/structure/views`) and edit any View that
   has more results than fit on one page.
2. Open its **Pager** settings and confirm **"Paged output, dropdown pager"** is
   available as an option.
3. Select it, save the View, and load the View on the front end to confirm the
   compact dropdown pager (for example "1 / 6") appears with working First /
   Previous / Next / Last controls.

For the full walkthrough, see "How to use it" in the [overview](../index.md).
