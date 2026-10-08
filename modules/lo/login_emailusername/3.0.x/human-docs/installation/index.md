# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **User** module (`user`) — always present in a Drupal site; it's the only
  dependency.

There are no third‑party Composer or PHP library requirements, and no configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/login_emailusername -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/login_emailusername -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_emailusername -y
```

That's the entire setup. The moment it's enabled, the login form's first field is
relabeled **"Username or email address"** and accepts both. There is **no settings
page** — nothing else to configure.

## Verify it worked

Log out, go to `/user/login`, and confirm the first field now reads **"Username or
email address."** Try logging in with a known account's email address (and password) —
it should sign you in just as the username would.
