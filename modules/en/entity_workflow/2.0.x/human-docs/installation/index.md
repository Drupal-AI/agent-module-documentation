# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement:
  ^11.3 || ^12`).
- Core's **Workflows** module (`workflows`).
- Core's **Workspaces** module (`workspaces`).
- No third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_workflow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_workflow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_workflow -y
```

Drupal enables the core **Workflows** and **Workspaces** dependencies
automatically.

## Submodules — enable them for ready-made workflows

The base module is mostly API. To get working workflows without building your own,
enable the submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Workflow Content** | `entity_workflow_content` | A basic workflow for content. |
| **Entity Workflow Workspace** | `entity_workflow_workspace` | A basic workflow for workspaces. |

For example:

```bash
drush en entity_workflow_content entity_workflow_workspace -y
```

## Verify it worked

Confirm the modules are enabled with `drush pm:list --status=enabled | grep
entity_workflow`. Then check that **Workflows** (**Configuration → Workflow →
Workflows**) and **Workspaces** are available, and review the permissions that
control transitions and workspace publishing. See
[Configuration](../configuration/index.md) for the setup details.
