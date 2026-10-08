# Installation

## Requirements

Responsive Layout Builder needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Layout Builder** module (`layout_builder`) — the layout system this
  module extends.
- Core's **Breakpoint** module (`breakpoint`).

Both core modules are enabled automatically as dependencies. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_layout_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_layout_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_layout_builder -y
```

You'll also want Layout Builder turned on for at least one content type's display
(**Structure → Content types → *(your type)* → Manage display → Manage layout**)
so you have a layout to make responsive.

## Verify it worked

Open the settings form for the module (see
[Configuration](../configuration/index.md)) and confirm you can define
breakpoints. Then edit a Layout Builder layout and configure a block — you should
see responsive/breakpoint options provided by this module.
