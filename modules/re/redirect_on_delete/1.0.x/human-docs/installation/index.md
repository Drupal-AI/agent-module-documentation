# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contrib **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — the redirects this module creates on delete are stored and
  served by Redirect, so it is required. Composer pulls it in with the `-W` flag
  below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_on_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_on_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_on_delete -y
```

Drupal enables the Redirect module automatically as a dependency if it is not
already on.

## Verify it worked

Delete a test piece of content. The deletion flow should prompt you to create a
redirect and suggest a default target (the nearest parent by menu or path).
Complete it, then confirm the old URL now redirects to the replacement instead of
returning a 404.
