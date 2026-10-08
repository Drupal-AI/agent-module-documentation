# Configuration

ECA is configured in two ways: you **enable the submodules** that supply the
events, conditions, and actions you need, and you **build models** in the visual
editor. ECA Core itself has no settings form — its configuration screen comes from
the ECA UI submodule.

## Turn on the UI and a modeler

1. Enable **ECA UI** (`eca_ui`) and a **modeler** such as `bpmn_io` (see
   [Installation](../installation/index.md)).
2. Go to **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`). This is
   the model list, and the UI's own **settings form** (which writes the
   `eca.settings` config) lives here too.

## Enable the capability submodules

ECA Core is inert; each subsystem you want to automate needs its `eca_*` submodule
enabled. Turn on only what you need:

| Submodule | Provides |
|---|---|
| `eca_ui` | The management UI at `/admin/config/workflow/eca` (needs a modeler). |
| `eca_base` | Base events (cron/custom), conditions, generic actions (set token, etc.). |
| `eca_content` | Content‑entity events (presave/insert/update/delete), conditions, actions. |
| `eca_form` | Form API events, conditions, actions (alter/validate/submit). |
| `eca_user` | User events (login/logout/register), conditions, actions. |
| `eca_workflow` | Content‑moderation state‑transition events and actions. |
| `eca_views` | Execute, iterate, and export Views query results. |
| `eca_access` | Access events, conditions, actions. |
| `eca_node_access` | Node view/edit/delete access control (also affects Views listings). |
| `eca_queue` | Queue events, conditions, and enqueue/process actions. |
| `eca_cache` | Cache actions. |
| `eca_config` | Config import/export events. |
| `eca_file` | File and file‑entity events, conditions, actions. |
| `eca_language` | Advanced language handling. |
| `eca_log` | Log‑message events and actions. |
| `eca_menu` | Menu‑link options and actions. |
| `eca_migrate` | Migrate events. |
| `eca_misc` | Miscellaneous kernel/core events and conditions. |
| `eca_render` | Rendering (blocks, links). |
| `eca_endpoint` | ECA‑served URL endpoints. |
| `eca_htmx` | HTMX polling regions, conditions/tokens, and HX‑* response headers. |
| `eca_development` | Dev‑only helpers — **not for production**. |

## Building a model

A **model** is an `eca` configuration entity that holds an ordered set of events,
conditions, and actions with their settings. To build one:

1. At `/admin/config/workflow/eca`, create a new model in your modeler.
2. Add a **starting event** (for example "a node is created"), one or more
   **conditions** to narrow when it runs, and the **actions** to perform.
3. Use **tokens** to pass data between steps — actions read and write named tokens.
   For scheduled work, use the cron‑based triggers (built on the cron‑expression
   library).
4. **Save** the model.

## After changing models or submodules

Whenever you add or change models, or enable submodules that register new triggers,
rebuild ECA's event subscribers so the new triggers actually fire:

```bash
drush eca:subscriber:rebuild
```

This also runs automatically on a cache rebuild (`drush cr`).

## Deploying models

Because models are configuration (`eca.eca.*.yml`), they export and import with
`drush config:export` / `config:import` and deploy between environments just like
any other Drupal config.
