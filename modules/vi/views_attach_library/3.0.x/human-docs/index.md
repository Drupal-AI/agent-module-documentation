# Attach Library In Views — manual setup guide

**Attach Library In Views** (`views_attach_library`) lets you attach any Drupal
asset library — CSS or JavaScript — to a View by simply typing its name in the
View's display settings. Normally, loading a stylesheet or a script only where a
particular View appears means writing a `hook_views_pre_render()` or a preprocess
function. This module removes that step: a site builder types a library name, and
the assets load with the View, scoped to just the pages where it renders.

It works by registering a Views **display extender** that it turns on automatically
when you install it. The extender adds an **Attach Library** option to each View
display, where you enter one or more library names in the standard
`provider/library` form (for example `mytheme/global` or `mymodule/slider`),
comma‑separated for multiple. When the View renders, the module reads those names
and pushes them onto the render array's `#attached` libraries so Drupal's asset
system loads them.

Because the setting lives on the View display, you can attach a library on the
**Default** display so every display inherits it, or override it per display (for
example, different assets for the page and block versions of the same View). The
settings are stored in the exported View config, so a feature's View and its assets
can ship together.

There is no global settings page, no permission, and no dependency beyond core
**Views**. It works on Drupal 11 and 12.

This guide is written for a **human** working in the Views UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You use it from inside a View at **Structure → Views**,
where an **Attach Library** option appears in each display's settings.

## How to use it

1. Edit a View at **Structure → Views** (`/admin/structure/views/view/<id>`).
2. In the display settings, find the **Attach Library** option (it appears through
   the display's options summary rather than as its own top‑level row).
3. Enter one or more library names in **`provider/library`** form — the `provider`
   is the module or theme, and `library` is the entry from its `*.libraries.yml`
   (for example `mytheme/global`, `mymodule/slider`). Separate multiple libraries
   with commas: `mymodule/slider, mytheme/global`.
4. Set it on the **Default** display so all displays inherit, or override it on a
   specific display.
5. Save the View. The listed libraries now load wherever that View renders.

Common uses: attaching a slider or carousel library to a carousel View, a datatables
or tablesorter library to a table View, a lightbox library used by fields inside the
View, or a small stylesheet to style one View's markup without adding global CSS.
Library names are used verbatim, so an invalid `provider/library` simply won't
resolve — double‑check the spelling against the library definition.
