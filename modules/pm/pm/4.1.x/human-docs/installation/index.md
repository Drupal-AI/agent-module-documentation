# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The base module pulls in a number of core and contrib dependencies, including
  core's **Block**, **CKEditor 5**, **Comment**, **Datetime** and **Datetime
  Range**, **Link**, **Options**, **Path**, **REST**, **Serialization**,
  **Text**, **Views** and **User** modules, plus the contrib modules **Views
  Entity Reference Filter** (`verf`), **Address** (`address`) and **Dynamic Entity
  Reference** (`dynamic_entity_reference`), and its own **PM UI** (`pm_ui`)
  submodule.
- Composer installs all of these automatically when you require the module with
  the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/pm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Address, Dynamic Entity Reference, VERF and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en pm -y
```

Then enable the submodules for the tools you actually want. For a typical
project-tracking setup:

```bash
drush en pm_project pm_task pm_sub_task pm_story pm_epic pm_feature pm_board -y
```

## Submodules

The suite is delivered as many separate, individually installable submodules.
Enable only the ones you need:

| Submodule | What it adds |
|-----------|--------------|
| `pm_project` | Project entities |
| `pm_epic`, `pm_feature`, `pm_story` | Higher-level work items |
| `pm_task`, `pm_sub_task` | Tasks and sub-tasks (with default bug/issue/task/test types) |
| `pm_board` | Kanban / Scrum boards |
| `pm_timetracking` | Time tracking against work items |
| `pm_invoice`, `pm_expense` | Invoices and expenses |
| `pm_note`, `pm_persona`, `pm_organization` | Notes, personas and organizations |
| `pm_status`, `pm_priority` | Custom statuses and priorities |
| `pm_rest` | REST views exposing PM entities |
| `pm_ui` | Single-Directory Component "pill" field formatter (installed as a dependency) |
| `pm_presets` | Preset/default configuration |

## Verify it worked

Log in as an administrator and visit **`/pm`**. You should see the PM dashboard
listing the tools you enabled. Create a project (if you enabled `pm_project`),
set its key prefix, and confirm that new child items are auto-numbered from it.

Next, grant the **Administer PM configuration** permission to your project
administrators and set up bundles, statuses, priorities and boards under
**`/admin/pm`**.
