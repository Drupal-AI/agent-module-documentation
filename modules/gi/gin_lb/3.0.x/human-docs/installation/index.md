# Installation

## Requirements

Gin Layout Builder has a few dependencies because it bridges Layout Builder and the
Gin admin theme:

- **Drupal 11.2** (`core_version_requirement: ^11.2`).
- Core's **Layout Builder** module (`layout_builder`).
- The **[Gin](https://www.drupal.org/project/gin)** admin theme (`drupal/gin`,
  version 5) — pulled in by Composer.
- The **[Gin Toolbar](https://www.drupal.org/project/gin_toolbar)** module
  (`gin_toolbar`, version 3) — a hard dependency.

> **Conflict:** don't use Gin Layout Builder together with `lb_claro` — they both try
> to re-skin Layout Builder and will fight. Pick one.

Gin Layout Builder is only useful when your site's **front-end** theme is *not* Gin —
it styles the layout UI that renders in that front-end theme. On a site that already
uses Gin as its front-end theme, the module intentionally does nothing.

## Install with Composer

From the project root:

```bash
composer require drupal/gin_lb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in the Gin theme and Gin Toolbar.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_lb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_lb -y
```

Make sure the **Gin** theme is installed and that **Layout Builder** and **Gin
Toolbar** are enabled (Composer and the dependency system handle most of this). If Gin
isn't installed yet:

```bash
drush theme:enable gin -y
```

## Optional submodule — Gin LB Plus

The package includes a submodule, **Gin LB Plus** (`gin_lb_plus`), which layers a more
opinionated, tabbed and icon-driven block/section picker on top of the styling. Enable
it only if you want that enhanced picker:

```bash
drush en gin_lb_plus -y
```

## Verify it worked

Edit the layout of any entity that uses Layout Builder (for example a content type with
Layout Builder enabled). The layout editing screen, the off-canvas "Add block" and
"Configure section" dialogs, and the Media Library modal should now appear in Gin's
style rather than your front-end theme's. To change any defaults, see
[Configuration](../configuration/index.md).
