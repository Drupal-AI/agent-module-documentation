# Installation

## Requirements

- **Drupal 11.3 only** (`core_version_requirement: ^11.3`) — current-edge; it will
  not install on older Drupal.
- **PHP 8.3 or newer** (`php: >=8.3`).
- The **FlowDrop UI Components** submodule (`flowdrop_ui_components`) is a
  dependency of the base module and installed with it.
- Several third-party PHP libraries are required and pulled in by Composer:
  `symfony/expression-language`, `symfony/property-access`,
  `d34dman/vanilla-icon-picker`, `loilo/jsonpath`, `dragonmantank/cron-expression`
  (cron-style trigger schedules), and `league/html-to-markdown`.

### Recommended (suggested) extras

- **`drupal/key`** — enables the `${{ secrets.NAME }}` reference syntax so
  credentials never land in workflow config or job records. Strongly recommended if
  any workflow authenticates to a model or API.
- **`league/commonmark`** — spec-compliant markdown-to-HTML for the *Markdown to
  HTML* node; without it a regex fallback is used.

> **Canvas caveat:** `flowdrop_ui_components` ships SDC components. Running it
> alongside the **Canvas** module has triggered an assertion fatal in Canvas's
> component discovery. If you use Canvas, test this in a non-production environment
> first.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve FlowDrop's required
libraries alongside the module. To add the recommended extras:

```bash
composer require drupal/key league/commonmark -W
```

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
| `flowdrop_trigger` | Event/cron/external triggers (cron expressions supported). |
| `flowdrop_job` | The background job system. |
| `flowdrop_interrupt` | Human-in-the-loop pauses and the confirmation gate. |
| `flowdrop_chat` | A chat surface backed by a workflow. |
| `flowdrop_playground` | A place to try nodes out. |
| `flowdrop_node_type`, `flowdrop_node_category`, `flowdrop_node_processor` | Node variants, palette organisation, and node processors. |
| `flowdrop_ui_components` | SDC components for the editor (a dependency). |

Enable them as needed, for example:

```bash
drush en flowdrop_workflow flowdrop_runtime flowdrop_trigger flowdrop_interrupt -y
```

## Upgrading from 2.0 / 2.1

The 2.2 upgrade is non-breaking. After updating the code, run:

```bash
drush updatedb
```

Two order-independent post-updates carry any stored `requires_confirmation`
tri-states forward into the new `confirmation` governance map, and the new
`administer flowdrop confirmation policy` permission is split off cleanly so it is
never a backward-compatibility break.

## Verify it worked

Visit the settings form at **`/admin/flowdrop/config/flowdrop`** and open the visual
workflow editor. If both load, the suite is installed. Continue to
[Configuration](../configuration/index.md) for settings, permissions, secrets, the
confirmation gate, and the trusted-publisher import model.
