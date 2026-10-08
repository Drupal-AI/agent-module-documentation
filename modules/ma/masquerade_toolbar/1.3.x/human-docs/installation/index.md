# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher** (the module uses typed properties throughout).
- The **Masquerade** module (`masquerade`) — a hard dependency that provides the
  core user‑switching functionality. Composer installs it for you with the `-W`
  flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/masquerade_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Masquerade
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masquerade_toolbar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masquerade_toolbar -y
```

Enabling Masquerade Toolbar also enables Masquerade if it is not already on.

## Verify it worked

Grant the necessary permissions (see [Configuration](../configuration/index.md)),
then browse the site as a user who has both **`use masquerade toolbar`** and a
Masquerade masquerade‑as permission. The floating toolbar should appear (by
default at the bottom right). Click it to expand, search for a user, and confirm
you can switch and switch back.
