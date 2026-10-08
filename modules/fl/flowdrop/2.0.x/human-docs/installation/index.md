# Installation

## Requirements

- **Drupal 11.3 only** (`core_version_requirement: ^11.3`) — this is a
  current-edge module; it will not install on older Drupal.
- The **FlowDrop UI Components** submodule (`flowdrop_ui_components`) is a
  dependency of the base module and is installed with it.
- FlowDrop is a suite of **18 submodules**. Enable the base module plus the
  submodules for the capabilities you actually need (runtime, workflow, triggers,
  chat, and so on).

> **Canvas caveat:** `flowdrop_ui_components` ships SDC components. On a review
> install, running it alongside the **Canvas** module triggered an assertion fatal
> in Canvas's component discovery. If you use Canvas, test this combination in a
> non-production environment first — FlowDrop was fine once Canvas was removed.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve FlowDrop's
dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module (this brings in `flowdrop_ui_components`):

```bash
drush en flowdrop -y
```

## Submodules

FlowDrop ships 18 submodules — enable only what your workflows use. The main
building blocks include:

| Submodule | What it provides |
|-----------|------------------|
| `flowdrop_runtime` | The execution runtime and secret settings. |
| `flowdrop_workflow`, `flowdrop_workflow_executor` | Workflow config entities and their execution. |
| `flowdrop_session`, `flowdrop_memory`, `flowdrop_stategraph` | State, memory, and checkpointed execution for conversational/long-running flows. |
| `flowdrop_pipeline` | The pipeline/execution-record abstraction. |
| `flowdrop_orchestration`, `flowdrop_orchestration_connector` | The orchestration layer and its connectors. |
| `flowdrop_trigger` | Event/cron/external triggers. |
| `flowdrop_job` | The background job system. |
| `flowdrop_interrupt` | Human-in-the-loop pauses/approvals. |
| `flowdrop_chat` | A chat surface backed by a workflow. |
| `flowdrop_playground` | A place to try nodes out. |
| `flowdrop_node_type`, `flowdrop_node_category`, `flowdrop_node_processor` | Node variants, palette organisation, and node processors. |
| `flowdrop_ui_components` | SDC components for the editor (a dependency). |

Enable them as needed, for example:

```bash
drush en flowdrop_workflow flowdrop_runtime flowdrop_trigger -y
```

## Verify it worked

Visit the FlowDrop settings form at **`/admin/flowdrop/config/flowdrop`** and the
FlowDrop admin area. If the settings form loads and you can open the visual
workflow editor, the suite is installed. Continue to
[Configuration](../configuration/index.md) for settings, permissions, secrets, and
the trusted-publisher import model.
