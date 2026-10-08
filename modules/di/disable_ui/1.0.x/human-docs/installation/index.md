# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11**
  (`core_version_requirement: ^8.7.7 || ^9.0 || ^10 || ^11`).
- Drupal core only — there are no module dependencies and no PHP library
  requirements. (It is designed to sit alongside core's RESTful Web Services and/or
  JSON:API on a decoupled site, which supply the API routes it deliberately leaves
  open.)

The project is **minimally maintained**; weigh that before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_ui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_ui -y
```

> **Grant the permission before you log out.** As soon as the module is enabled,
> HTML routes require the **Access UI routes** permission. Make sure your own
> administrator role has that permission (see the "How to use it" section of the
> [overview](../index.md)) so you don't lock yourself out of the UI. The login and
> password-reset routes stay open by default, so you can always sign back in.

## Verify it worked

Grant **Access UI routes** to your admin/developer roles, then:

- Confirm an administrator can still browse themed HTML pages.
- Confirm a user *without* the permission is blocked from HTML pages but that your
  API endpoints (REST / JSON:API) still respond for API clients.
- Confirm login, logout, and password reset are still reachable.
