# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`) enabled — this is the only dependency, and
  it is on by default on a standard Drupal site.
- A Bootstrap‑based theme for the added classes (`.table`, `.img-fluid`,
  `.blockquote`, `.figure`, …) to actually have styling to apply.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_utilities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap_utilities -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_utilities -y
```

Enabling the module makes the four filters available, but does **not** turn them on
anywhere — filters are enabled per text format. Go to **Configuration → Content
authoring → Text formats and editors**, configure a format, and tick the filters
you want (see the [overview](../index.md#how-to-use-it)).

## Verify it worked

Edit a text format at `/admin/config/content/formats/manage/full_html` and look in
the **Enabled filters** list. You should see the four **Bootstrap Utilities -**
filters available to enable.
