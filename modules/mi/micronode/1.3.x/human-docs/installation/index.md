# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Node** module (`node`), which Drupal enables automatically as a
  dependency.

There are no third‑party PHP library requirements. Two optional modules integrate
nicely if you already use them:

- **Admin Toolbar** (specifically `admin_toolbar_tools`) — adds an "Add
  Micro‑Content" grouping to the toolbar's add links.
- **Type Tray** (`drupal/type_tray`) — when present, micronode leaves the
  `/node/add` page to Type Tray rather than substituting its own controller.

## Install with Composer

From the project root:

```bash
composer require drupal/micronode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/micronode -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en micronode -y
```

There are no submodules and no install‑time configuration. You flag content types
individually afterward (see [Configuration](../configuration/index.md)).

## Verify it worked

Edit any content type (**Structure → Content types → *(your type)* → Edit**). You
should see a new **Micro‑content settings** vertical tab with an **Is
micro‑content** checkbox. Tick it and save to try the behavior; see
[Configuration](../configuration/index.md) for what changes.
