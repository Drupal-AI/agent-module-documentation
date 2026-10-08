# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which is part of a standard Drupal install.
  There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/anonymous_redirection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anonymous_redirection -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anonymous_redirection -y
```

As soon as it is enabled, anonymous visitors are redirected to `/user/login`.
Verify that the login, password‑reset, and registration paths remain reachable so
people can still sign in.
