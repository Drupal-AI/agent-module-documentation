# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Group** module (`drupal/group`, `^1 || ^2@beta || ^3@beta`) — the required dependency.
  Group Actions works with Group v1, v2, or v3.
- To actually *use* the actions you'll want a consumer of Drupal actions — most commonly the
  **Views Bulk Operations (VBO)** module or the **ECA** module. These are not hard
  dependencies of Group Actions, but without one of them there's nowhere to run the actions
  from.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Group module and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_action -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_action -y
```

Drupal enables the Group module automatically as a dependency. Once enabled, the six group
actions become selectable in VBO views and ECA models — see
[Configuration](../configuration/index.md) for what each does and how to set it up.
