# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** (`image`) and **Content Moderation** (`content_moderation`) modules.
- The contrib **Scheduler** (`scheduler`) module, used for publish scheduling. Composer pulls it
  in automatically.
- A **Content Moderation workflow** with at least one enabled content type — the calendar and
  kanban boards need moderation states to show anything. You can set this up before or after
  installing (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/content_planner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Scheduler and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_planner -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_planner -y
```

## Submodules — enabled automatically

Content Planner ships two submodules that make up the calendar and board. **Installing the base
module also enables both of them**, so you normally don't enable them by hand:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Content Calendar** | `content_calendar` | A month‑by‑month editorial calendar with drag‑to‑reschedule, colour‑coding by content type, and node duplication. |
| **Content Kanban** | `content_kanban` | A kanban board of content cards grouped by moderation state, with drag‑to‑transition and a log of every state change. |

Each submodule has its own permissions and settings — see its own documentation for details.

## Next step

Head to [Configuration](../configuration/index.md) to arrange your dashboard widgets, set
permissions, and confirm the moderation‑workflow prerequisite.
