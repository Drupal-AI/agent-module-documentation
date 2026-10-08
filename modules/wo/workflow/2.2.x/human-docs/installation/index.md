# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`), **Options** (`options`), and **User** (`user`) modules,
  all part of a standard Drupal install and enabled automatically as dependencies.
- No third-party Composer packages or PHP library requirements.

### Optional companions

The module suggests two contrib modules for extra features (install them only if you
want the feature):

- **Diff** (`drupal/diff`) — makes workflow state changes appear in entity revision diffs.
- **Feeds** (`drupal/feeds`) — provides a Feeds target for importing workflow state
  values.

## Install with Composer

From the project root:

```bash
composer require drupal/workflow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/workflow -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workflow -y
```

That gives you the core Workflow feature: creating workflows and attaching the Workflow
state field. Next, grant the **Administer workflow** permission to the roles that should
manage workflows, then head to [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Workflow ships several submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Workflow Access** | `workflow_access` | Controls node **access** based on the current workflow state — for example, hiding draft content from anonymous users. |
| **Workflow Cleanup** | `workflow_cleanup` | Tools to clean up orphaned or inactive states left behind after editing a workflow. |
| **Workflow Devel** | `workflow_devel` | A development aid that logs every workflow hook call — useful when building add-ons. |

Three further submodules — `workflowfield`, `workflow_operations`, and `workflow_ui` —
are obsolete/residual: their functionality has been folded into the main Workflow module,
so you don't need to enable them on a current site.

For example, to add state-based node access control:

```bash
drush en workflow_access -y
```
