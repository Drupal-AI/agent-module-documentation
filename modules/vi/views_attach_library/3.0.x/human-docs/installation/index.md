# Installation

## Requirements

Attach Library In Views is self‑contained:

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- Core's **Views** module enabled (part of core).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_attach_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_attach_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_attach_library -y
```

There are no submodules and no configuration form. When it is enabled, the module
automatically switches on its Views display extender (by adding itself to
`views.settings`), so the **Attach Library** option appears in your View displays
right away — see the [overview](../index.md) for how to use it. (If the extender is
ever inactive, re‑saving `views.settings` with the extender listed restores it.)
