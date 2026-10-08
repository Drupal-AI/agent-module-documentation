# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_anonymous_users -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_anonymous_users -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_anonymous_users -y
```

> **Heads-up:** the module takes effect immediately. As soon as it is enabled,
> anonymous visitors can reach **only** the login page — every other route
> redirects there until you add it to the exclusion list. Enable it and then go
> straight to the settings form to build that list (see
> [Configuration](../configuration/index.md)). Keep an admin session open so you
> do not lock yourself out mid-setup.

## Verify it worked

In a separate, logged-out browser (or a private window), try to visit any
front-end page. You should be redirected to `/user/login`. Then, once you have
configured the exclusions, confirm those allowed routes load without redirecting.
