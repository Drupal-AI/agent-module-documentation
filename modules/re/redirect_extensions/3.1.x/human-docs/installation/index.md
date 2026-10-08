# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The contrib **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — it must be present and enabled, since this module extends it.
- The contrib **[Views data export](https://www.drupal.org/project/views_data_export)**
  module (`views_data_export`) — used for the CSV export feature.

Both dependencies are pulled in by Composer with the `-W` flag below. There are no
third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_extensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Redirect and Views
data export and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_extensions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure the Redirect module is enabled, then:

```bash
drush en redirect_extensions -y
```

Drupal enables Redirect and Views data export automatically as dependencies if
they are not already on.

## Verify it worked

As a user with the **administer redirects** permission, visit
`/admin/config/search/redirect`. You should be able to reach the bulk status-code
form at `/admin/config/search/redirect/edit/status` and the bulk destination form
at `/admin/config/search/redirect/edit/dest`, and the listing should show the new
created/updated tracking columns and a clickable "To" link.
