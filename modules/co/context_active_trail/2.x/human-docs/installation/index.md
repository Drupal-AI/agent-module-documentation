# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Context** module (`drupal/context`, `^5.0`) — this module is a reaction
  plugin for Context, so Context must be present. Composer installs it for you.
- The **Context UI** submodule (part of Context) — strongly recommended, since
  you configure the Active trail reaction through the Context admin interface.

There are no third‑party Composer or PHP library requirements, and the module
adds no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/context_active_trail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Context
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/context_active_trail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en context_active_trail -y
```

Make sure the **Context UI** submodule is enabled too so you can configure the
reaction:

```bash
drush en context_ui -y
```

On enable, the module clears the render cache once (so any previously cached
breadcrumbs are re‑evaluated). There are no submodules of its own.

## Next step

There is no settings page. Add the **Active trail** reaction inside a context —
see the [overview](../index.md) for the step‑by‑step and the reaction's fields.
