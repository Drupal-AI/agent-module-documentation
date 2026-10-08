# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (part of the standard install).
- **ECA** (`drupal/eca`, `^2.0 || ^3.0`) — the automation engine. You'll also want
  a modelling UI submodule from the ECA project (such as *BPMN.iO* or *ECA Classic
  Modeller*) so you can build models in the browser.
- **Views Bulk Operations** (`drupal/views_bulk_operations`, `^4.2`).

Composer pulls in ECA and Views Bulk Operations automatically, and Drupal enables
them (and Views) as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_vbo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the ECA and Views
Bulk Operations dependencies and any shared packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_vbo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_vbo -y
```

Drupal enables **ECA**, **Views Bulk Operations**, and **Views** at the same time
because they're dependencies. If you installed a separate ECA modeller submodule,
enable that too (for example `drush en eca_ui bpmn_io -y`) so you can build models in
the UI.

There are no submodules of ECA VBO itself and no permissions to grant. Once
everything is on, head to [Configuration](../configuration/index.md) to build your
first operation.
