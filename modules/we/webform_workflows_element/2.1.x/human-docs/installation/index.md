# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Workflows** module (`workflows`) — enabled as a dependency.
- The **Webform** module (`drupal/webform` `^6.3`) — enabled as a dependency;
  Composer pulls it in if it isn't already present.

No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_workflows_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webform_workflows_element -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_workflows_element -y
```

Enabling it also enables core Workflows and Webform if they aren't already on.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Webform Workflows Element: Views** | `webform_workflows_element_views` | A Views filter so you can filter a list of submissions by workflow state. |
| **Webform Workflows Element: Maestro** | `webform_workflows_element_maestro` | Maestro engine tasks, so submission transitions can be driven from a Maestro business-process template (requires the Maestro module). |

For example:

```bash
drush en webform_workflows_element_views -y
```

Each submodule requires the base module, which is already present once installed
above.

Next, build your workflow and add the element — see
[Configuration](../configuration/index.md).
