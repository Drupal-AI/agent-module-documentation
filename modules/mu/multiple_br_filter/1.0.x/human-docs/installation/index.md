# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** module (`filter`), which ships with Drupal and is enabled as a
  dependency automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_br_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multiple_br_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_br_filter -y
```

Enabling the module makes the filter available; you still need to turn it on for
each text format where you want it (see "How to use it" on the
[overview page](../index.md)).

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a text format. Under **Enabled filters**
you should now see **Remove multiple consecutive `<br>` tags**. Enable it, save, then
view content in that format that contained several stacked line breaks — they should
render as a single break.
