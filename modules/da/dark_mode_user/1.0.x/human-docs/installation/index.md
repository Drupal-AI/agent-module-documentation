# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- No module dependencies and no third‑party PHP or JavaScript library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dark_mode_user -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dark_mode_user -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dark_mode_user -y
```

## After enabling

- Set the site‑wide **default mode** in the module's admin settings.
- Grant the **`access dark mode user`** permission to the roles who should be able
  to choose their own light / dark / system preference (**People → Permissions**).

## Verify it worked

As a user with the `access dark mode user` permission, choose a mode and reload —
the site should switch between light and dark, and your choice should stick on the
next visit. Set the global default to confirm anonymous or new users get the mode
you expect.
