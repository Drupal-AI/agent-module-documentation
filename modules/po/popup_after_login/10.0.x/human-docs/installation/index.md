# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`). This release does
  not declare Drupal 11 support — check the project page for a newer release if you
  are on Drupal 11.
- The **SweetAlert2** (`sweetalert2`) library module, which provides the popup
  rendering. It is a dependency and must be present.

Note this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/popup_after_login -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the **SweetAlert2** dependency
and updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/popup_after_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en popup_after_login -y
```

Drupal enables the `sweetalert2` dependency for you.

## Verify it worked

1. Configure at least one popup with a title and a target role (see
   [Configuration](../configuration/index.md)).
2. Clear the cache (`drush cr`).
3. Log in as a user in the targeted role — the SweetAlert2 popup should appear. If
   you configured the first-login popup, it should appear only on the first login
   and not again.
