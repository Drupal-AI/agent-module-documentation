# Installation

## Requirements

Piano Analytics needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **Piano Analytics / AT Internet account** with a site ID (and, for
  server‑side tracking, API credentials from Piano).

There are no third‑party Composer library requirements — the client‑side tracker
is loaded from Piano's servers at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/pianoanalytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pianoanalytics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pianoanalytics -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Piano Analytics Server** | `pianoanalytics_server` | Server‑side tracking — sends events to Piano's Collection API from Drupal (rather than only from the browser), which survives ad blockers and lets other modules queue events. Enable it only if you want server‑side tracking; it needs Piano API credentials (see [Configuration](../configuration/index.md)). |

Enable it when you need it:

```bash
drush en pianoanalytics_server -y
```

## Verify it worked

After enabling and entering your Piano site ID (see
[Configuration](../configuration/index.md)), load a front‑end page as an anonymous
visitor and confirm in your browser's developer tools that the Piano tracker
loads and sends a request — and that hits appear in your Piano Analytics
dashboard. Remember to configure consent handling before relying on it in
production.
