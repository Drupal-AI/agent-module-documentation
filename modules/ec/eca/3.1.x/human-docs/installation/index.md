# Installation

## Requirements

- **Drupal 11.3+ or 12** (`core_version_requirement: ^11.3 || ^12.0`).
- **PHP 8.3 or newer**, with the JSON extension.
- The contributed **Modeler API** module (`modeler_api` `^1.1`), enabled
  automatically as a dependency.
- Composer library **`dragonmantank/cron-expression`** `^3.1` (installed
  automatically) — used for scheduled, cron‑based triggers.
- To actually build models you will also need the **ECA UI** submodule and a
  **modeler** module such as `bpmn_io` (installed separately — see below).

## Install with Composer

From the project root:

```bash
composer require drupal/eca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Modeler API and the
cron‑expression library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/eca -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

To also get the visual editor, require a modeler — the most common is BPMN.iO:

```bash
composer require drupal/bpmn_io -W
```

## Enable the module

```bash
drush en eca -y
```

ECA Core on its own does nothing visible — you must enable the UI and the
capability submodules you need.

## Submodules — enable what you need

ECA Core is the engine; every actual event, condition, and action comes from an
`eca_*` submodule. Enable the management UI plus the subsystems you want to
automate. A few of the most‑used ones:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ECA UI** | `eca_ui` | The management screen at `/admin/config/workflow/eca` (needs a modeler such as `bpmn_io`). |
| **ECA Base** | `eca_base` | Base events (cron/custom), conditions, and generic actions (set token, etc.). |
| **ECA Content** | `eca_content` | Content‑entity events (presave/insert/update/delete), conditions, actions. |
| **ECA Form** | `eca_form` | Form API events, conditions, and actions (alter/validate/submit). |
| **ECA User** | `eca_user` | User events (login/logout/register), conditions, actions. |
| **ECA Workflow** | `eca_workflow` | Content‑moderation state‑transition events and actions. |
| **ECA Views** | `eca_views` | Execute, iterate, and export Views query results. |

For example, to enable the UI and content automation:

```bash
drush en eca_ui eca_base eca_content -y
```

There are many more (`eca_access`, `eca_queue`, `eca_cache`, `eca_config`,
`eca_file`, `eca_log`, `eca_menu`, `eca_endpoint`, `eca_htmx`, and others) — see
[Configuration](../configuration/index.md) for the full capability map. The
`eca_development` submodule is a dev‑only helper and should not be enabled in
production.

After enabling submodules or changing models, rebuild ECA's event subscribers so
new triggers take effect:

```bash
drush eca:subscriber:rebuild
```
