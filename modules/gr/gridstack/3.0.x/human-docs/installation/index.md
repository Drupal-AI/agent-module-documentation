# Installation

## Requirements

GridStack needs:

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- Core's **Layout Discovery** module (`layout_discovery`) — enabled
  automatically as a dependency.
- The **Blazy** module, version 3.x or newer (`blazy:blazy (>= 3.x)`), pulled
  in by Composer.
- The third‑party **GridStack.js library** (v4–v5 for this branch), downloaded
  into your site's `libraries/` directory — see below.
- For the richer Layout Builder grids, an **unlimited (multi‑value) core Media
  field** on the content type you are laying out.

## Install with Composer

From the project root:

```bash
composer require drupal/gridstack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (such as Blazy) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gridstack -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the GridStack.js library

The module integrates the GridStack.js library but does **not** ship it. Download
it and place it under your site's `libraries/` directory so the files resolve to:

- `/libraries/gridstack/dist/gridstack-h5.js` — used by the admin UI.
- `/libraries/gridstack/dist/gridstack-static.js` — used for JS front‑end grids
  (optional; static grids such as Native Grid, Bootstrap, and Foundation do not
  require it).

The 3.x branch was tested up to library **v5.1.1**. After placing the files,
visit **Reports → Status report** (`/admin/reports/status`) to confirm Drupal
detects the library.

## Enable the module

```bash
drush en gridstack -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GridStack Layouts** | `gridstack_layouts` | Ready‑to‑use GridStack layouts for Layout Builder, so you can start composing grids immediately. |
| **GridStack UI** | `gridstack_ui` | The management UI at **Structure → GridStack** for creating and editing grid layout definitions. |
| **GridStack Example** | `gridstack_example` | Demo grids and sample blocks to illustrate the workflow. |

For example, to enable the Layout Builder layouts and the management UI:

```bash
drush en gridstack_layouts gridstack_ui -y
```

Uninstall the example submodule once you no longer need the demos.

## Verify it worked

1. Check **Reports → Status report** — the GridStack library should be reported
   as installed.
2. With `gridstack_ui` enabled, visit **Structure → GridStack** and confirm the
   grid‑management screen loads.
3. On a Layout Builder–enabled display, add a section and confirm the **GridStack**
   layouts appear in the layout list. Remember to clear the cache
   (`drush cr`) after adding any new grid layouts.
