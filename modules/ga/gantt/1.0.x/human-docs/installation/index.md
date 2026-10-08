# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (enabled by default) — the chart is a View format.
- The **dhtmlxGantt** JavaScript library. By default it loads from a CDN, so
  nothing extra is required to get started. If you own the **PRO** version, place
  it at `/libraries/gantt/codebase/` instead.
- No third‑party Composer or PHP library requirements for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/gantt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gantt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gantt -y
```

## Submodule — Gantt Node demo

If you are not a Drupal expert (or just want a fast start), enable the demo
submodule. It creates a ready‑made **Gantt** content type and a matching View:

```bash
drush en gantt_node -y
```

The first time, create a task at **`/node/add/gantt`**, then visit **`/gantt`** to
use the interactive chart.

## Verify it worked

Grant Gantt's permissions at **People → Permissions**. Then either open **`/gantt`**
(if you enabled the demo) and confirm the interactive chart renders, or edit a
View at **Structure → Views**, open its **Format** settings, and confirm the
**Gantt** style is available.
