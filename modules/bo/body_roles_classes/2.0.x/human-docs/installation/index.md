# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No other Drupal modules and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/body_roles_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/body_roles_classes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en body_roles_classes -y
```

Or enable **Body Roles Classes** from *Extend* (`/admin/modules`).

There are no submodules. The module works as soon as it is enabled — role‑based
classes start appearing on the `<body>` element (with `administrator` excluded by
default). To tune the prefix, excluded roles, or per‑role class map, use the settings
form or Drush.

> **Note on the settings form.** In this version the settings form requires a
> permission the module does not define, so only user 1 can open it out of the box.
> If you are not user 1, set the configuration with Drush (for example
> `ddev drush config:set body_roles_classes.settings prefix 'r-' -y`). See
> [How to use it](../index.md#how-to-use-it) for the full list of settings.
