# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Chaos Tools (CTools)** — `drupal/ctools` `^3.15 || ^4.1`.
- **jQuery UI Droppable** — `drupal/jquery_ui_droppable` `^1.0 || ^2.0`.
- Core's **Layout Discovery** module (`layout_discovery`), enabled automatically
  as a dependency.

Composer resolves the CTools and jQuery UI Droppable requirements for you. To do
anything useful you will also want **Page Manager** (part of the CTools project)
or the bundled Panels IPE submodule — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/panels -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
dependencies (CTools, jQuery UI Droppable) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/panels -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en panels -y
```

Remember that Panels provides no interface of its own. To build pages you need an
implementing module — the usual choice is **Page Manager**:

```bash
composer require drupal/ctools -W
drush en page_manager page_manager_ui -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Panels IPE** | `panels_ipe` | A JavaScript in-place editor that lets you build and edit a Panels display directly on the rendered page — drag blocks between regions, add block content inline, and switch layouts. Enable it if you want front-end editing rather than driving everything through Page Manager's admin forms. |

```bash
drush en panels_ipe -y
```

## Verify it worked

After enabling, visit **Structure → Panels** (`/admin/structure/panels`) — the
Panels Dashboard should load. Then, with Page Manager enabled, go to
**Structure → Pages**, add a page, and confirm that **Panels** appears as a
choice when you add a display variant. If you enabled Panels IPE, open a page
that renders through a Panels display and you should see the in-place editing
toolbar.
