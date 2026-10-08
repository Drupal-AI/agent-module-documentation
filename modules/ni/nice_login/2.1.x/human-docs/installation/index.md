# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a Drupal site.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nice_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nice_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nice_login -y
```

There are no submodules and nothing to configure.

## Verify it worked

Log out (or open a private browser window) and visit `/user/login`. The Login /
Reset password / Create account tabs should be gone, and the login form should now
show "Forgot your password?" and — if self-registration is enabled — "Create an
account?" links. From here, styling is done in your theme; see **How to use it**
on the [overview page](../index.md).
