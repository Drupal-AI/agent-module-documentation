# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — a hard dependency.
- No third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/maestro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/maestro -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en maestro -y
```

This installs the engine, its entities/tables, and the task plugin system.

## Submodules — enable what your workflow needs

The base module is the engine; the interactive pieces and integrations ship as
submodules. Enable the ones you need with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Template Builder** | `maestro_template_builder` | The visual, drag-to-connect editor for building workflow templates. Almost everyone wants this. |
| **Task Console** | `maestro_taskconsole` | The UI where assigned users see and complete their tasks. |
| **Webform integration** | `maestro_webform` | Use Webform submissions as interactive tasks. |
| **ECA task** | `maestro_eca_task` | Trigger/react with the ECA (Events–Conditions–Actions) module. |
| **AI task** | `maestro_ai_task` | An AI-powered task type. |
| **Tool task** | `maestro_tool_task` | A tool/utility task type. |
| **Utilities** | `maestro_utilities` | Extra helper functionality. |
| **Variable Entity Identifier** | `maestro_variable_entity_identifier` | Link process variables to entity identifiers. |

For example, a minimal usable setup:

```bash
drush en maestro maestro_template_builder maestro_taskconsole -y
```

## Grant permissions

Maestro ships several permissions (mostly **restrict access**, i.e. trusted-admin
only). Assign them at **People → Permissions**
(`/admin/people/permissions`). The main ones:

- **Administer Maestro templates** — build/edit/delete templates and use the
  trace/debug tools.
- **Start Maestro process** — launch a process from a template.
- **Administer Maestro queue entities** — queue admin and task reassignment.
- **View Maestro task console** — see the task-console status endpoints.
- A per-template **"Put the *(template)* template into production"** permission is
  generated for each validated template, so you can let a role start one specific
  workflow.

## Verify it worked

Go to **Configuration → Workflow → Maestro**
(`/admin/config/workflow/maestro`) — the engine settings form should load. If you
enabled the Template Builder, you can now start creating a workflow template. Next,
see [Configuration](../configuration/index.md).
