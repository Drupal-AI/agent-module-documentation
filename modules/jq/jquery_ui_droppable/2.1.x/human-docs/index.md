# jQuery UI Droppable — manual setup guide

**jQuery UI Droppable** (`jquery_ui_droppable`) re-provides the jQuery UI Droppable
library as a contrib module. Drupal core used to bundle this interaction as
`core/jquery.ui.droppable`, but jQuery UI is no longer actively maintained and has
been marked End of Life, so core deprecated and removed it. This module brings the
"drop target" behavior back so themes and modules that turn elements into drop
zones keep working.

It is purely a library provider. The module declares a single asset library,
`jquery_ui_droppable/droppable`, whose contents are supplied by the base
`jquery_ui` module — there is no configuration UI, no permissions, no services, and
no plugins. Because a drop target only makes sense next to draggable items, it
depends on both **jQuery UI** and **jQuery UI Draggable**.

To migrate legacy code, swap any `core/jquery.ui.droppable` reference in your theme
or custom module for `jquery_ui_droppable/droppable`. Note that the maintainers
themselves recommend moving to a maintained drag-and-drop library rather than
building new features on jQuery UI, since it is End of Life — this module is best
used as a bridge that keeps existing code running during that migration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — this module has no admin pages, no settings form, and no permissions.
Once enabled it simply makes the `jquery_ui_droppable/droppable` asset library
available to attach.

## How to use it

There is nothing to configure. Attach the library where you need the droppable
interaction:

- In a theme or module's `*.libraries.yml`, add `jquery_ui_droppable/droppable` as
  a dependency of your own library.
- In a render array, add it under `#attached`:

  ```php
  $build['#attached']['library'][] = 'jquery_ui_droppable/droppable';
  ```

- When porting old code, replace every `core/jquery.ui.droppable` reference with
  `jquery_ui_droppable/droppable`.

Pair it with `jquery_ui_draggable/draggable` when you need a complete drag-and-drop
pairing.
