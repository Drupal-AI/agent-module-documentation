# Layout Disable — manual setup guide

**Layout Disable** (`layout_disable`) gives you an admin screen to hide unwanted
layout plugins — whether they come from core, a theme, or a contrib module — so
they no longer appear in any layout picker. Wherever Drupal lists layouts (Layout
Builder's section chooser, Display Suite, an entity view display's layout
selector), the layouts you disable simply vanish from the list.

It's a governance tool: use it to trim a long, confusing layout list down to an
approved set, to keep editors from picking off-brand or broken layouts, or to hide
experimental layouts on a production site — all without uninstalling the module or
theme that provides them. Disabling a layout only hides it from selection; it does
not remove or break the layout itself, and you can re-enable it any time by
unticking it.

The module is a thin wrapper around Drupal's layout system: one admin form lists
every discovered layout as a checkbox, and the ones you tick are removed from the
layout definitions everywhere. The core-required layouts `layout_onecol` and
`layout_builder_blank` are deliberately excluded and can't be disabled. It depends
on core's **Layout Discovery** module, adds an *Access layout_disable* permission,
and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which layouts to disable.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Layout Disable**
(`/admin/config/user-interface/layout-disable`).
