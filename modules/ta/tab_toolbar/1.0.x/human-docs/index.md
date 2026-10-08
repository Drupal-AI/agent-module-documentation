# Tab Toolbar — manual setup guide

**Tab Toolbar** (machine name `tab_toolbar`, project title *Tabs in Toolbar*)
moves a page's local task tabs — the *View / Edit / Delete* style tabs, plus any
secondary sub-tabs — out of the page body and into a **Page Actions** tray in
Drupal's admin toolbar. Instead of the tabs sitting in the content area (where a
custom theme may hide or restyle them), your editors get a consistent, tucked-away
actions menu anchored in the toolbar.

It works by implementing `hook_toolbar()` to add the Page Actions item, pulling
the current route's primary and secondary local tasks from core and rendering them
as a toolbar drop-down. The tray only appears on pages that actually have local
tasks, and it carries the right cache metadata so each user only ever sees the
tabs they're allowed to reach. It depends only on core's **Toolbar** module and
adds no permissions or services of its own.

By default the tabs are shown on the front-end theme but **hidden while you're on
the admin theme** (where core already shows tabs). A single configuration
checkbox flips that, so you can surface the Page Actions tray on the admin theme
too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module's one setting sits at **Configuration → Tab Toolbar → Settings**
(`/admin/config/tab_toolbar/settings`), behind the core **Administer site
configuration** permission.

## How to use it

There's almost nothing to set up. Once the module is enabled, browse to any page
that has tabs (for example a node) and you'll see a **Page Actions** item in the
toolbar whose tray lists that page's tabs.

The only option is a single checkbox on the settings form:

- **Show on the admin theme** *(default: off)* — when off, the Page Actions tray is
  hidden while the active theme is your site's admin theme (because the admin theme
  already renders tabs in the page). Tick it to show the toolbar tray on the admin
  theme as well. You can also set it from the command line:

  ```bash
  drush config:set tab_toolbar.settings admin.enabled true -y
  ```

If you want to restyle the tray, override the `tab-toolbar.html.twig` template
(theme hook `tab_toolbar`, with `primary` and `secondary` variables) in your
theme; individual items still render through core's `menu-local-task.html.twig`.
