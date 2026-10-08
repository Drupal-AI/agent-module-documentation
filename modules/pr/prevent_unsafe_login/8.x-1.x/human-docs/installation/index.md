# Installation

## Requirements

- **Drupal 8.7.7+, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- No other modules and no third‑party libraries are required.

The module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_unsafe_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevent_unsafe_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevent_unsafe_login -y
```

That's all — there is no configuration.

## Verify it worked

Visit the login form (`/user/login`) over plain `http://` (for example on a local
environment). The username and password fields should be **disabled**, with a
message stating that login over a non‑HTTPS connection is forbidden. Loading the
same form over `https://` should present a normal, working login. If you're locked
out of a no‑HTTPS environment, use `drush uli` for a one‑time login link.
