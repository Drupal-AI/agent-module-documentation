# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`).
- The contributed **Hook Event Dispatcher** module — specifically its **Core Event
  Dispatcher** submodule (`core_event_dispatcher`). The 3.0.x branch of Layout
  Builder Kit uses Hook Event Dispatcher 4.x, so this must be present and enabled
  for the kit to work.

There are no third‑party Composer library requirements beyond Hook Event
Dispatcher.

> **Status note:** this project is in **maintenance‑only** status (no further
> feature development) and is **not covered** by Drupal's security advisory policy.
> Weigh both before adopting it for new work.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_kit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Hook Event
Dispatcher and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_kit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_kit -y
```

Also make sure the **Core Event Dispatcher** module is enabled — enable it from
**Extend** (`/admin/modules`) or with Drush if it is not turned on automatically:

```bash
drush en core_event_dispatcher -y
```

## Verify it worked

Open a Layout Builder layout and click **Add block**. You should see the Layout
Builder Kit components (Image, Rich Text, Video, Tab, and so on) in the palette. If
they appear, the module is working — then review the settings form and permission
in [Configuration](../configuration/index.md).
