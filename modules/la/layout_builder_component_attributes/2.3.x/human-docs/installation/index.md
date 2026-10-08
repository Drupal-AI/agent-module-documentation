# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — this is the only dependency,
  and Drupal enables it (and its own dependencies) automatically when you turn this
  module on. You will also want Layout Builder actually in use on at least one
  display for the feature to be visible.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_component_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_component_attributes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_component_attributes -y
```

Enabling it also enables Layout Builder if it is not already on.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`):

- **Administer layout builder component attributes** — reach the global settings form
  and decide which attribute types are allowed. An administrative permission for
  trusted users.
- **Manage layout builder component attributes** — use the per‑block *Manage
  attributes* form to add attributes to components. Grant this to your layout
  editors. (They also need the usual Layout Builder access to edit the layout.)

For example:

```bash
drush role:perm:add layout_editor 'manage layout builder component attributes'
```

## Verify it worked

Edit a layout that uses Layout Builder, open a block's contextual menu, and confirm
a **Manage attributes** link appears just after *Configure*. Then tune the global
policy at **Configuration → Content authoring → Layout Builder Component
Attributes** — see [Configuration](../configuration/index.md).
