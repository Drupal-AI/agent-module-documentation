# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contrib **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — Redirect Expire adds an expiry to the redirects Redirect
  manages, so it is required. Composer pulls it in with the `-W` flag below.

There are no third‑party PHP library requirements. This release is a beta
(1.0.0-beta1).

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_expire -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_expire -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_expire -y
```

Drupal enables the Redirect module automatically as a dependency if it is not
already on.

## Verify it worked

Edit any redirect at `/admin/config/search/redirect`. The add/edit form should now
include the **expiration** field that this module adds. Set an expiry, save, and
confirm the redirect stops resolving once that date has passed.
