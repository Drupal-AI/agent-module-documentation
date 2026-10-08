# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — the only dependency, normally already enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/calendar_view -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_view -y
```

Once enabled, the **Calendar by month** and **Calendar by week** formats are available
when you build a View — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Calendar View ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Calendar View Multiday** | `calendar_view_multiday` | Improves the rendering of events that span several days, so a multi‑day event appears on each day it covers. |
| **Calendar View Demo** | `calendar_view_demo` | Ships ready‑made example calendar Views you can look at or copy. |

For example, to render multi‑day events nicely:

```bash
drush en calendar_view_multiday -y
```

Each submodule requires the base Calendar View module, which is already present once you
have installed it above.
