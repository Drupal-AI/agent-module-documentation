# Disable Field Button — manual setup guide

**Disable Field Button** (`disable_field_button`) adds a one-click **Disable** button
to each field's settings on the **Manage display** and **Manage form display** pages.
In Drupal core, taking a field out of a display means dragging its row down into the
"Disabled" section at the bottom of the page — fiddly on long displays. This module
gives you a faster alternative: expand a field's settings, click **Disable**, and the
field is immediately moved to the Disabled section and the display is saved.

The button appears in red alongside the existing **Update** and **Cancel** buttons in
a field's settings form, on both the view display and the form display, and it works
for every entity type and bundle — nodes, taxonomy terms, users, media, and so on.
It saves the display right away, so there's no need to scroll down and click the
page's Save button, and it shows a confirmation message afterwards.

There is **nothing to configure** — install it and it just works. It depends on
core's Field UI module and requires Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form and
requires none.

## How to use it

1. Go to any **Manage display** or **Manage form display** page — for example
   `/admin/structure/types/manage/article/display`.
2. Click the gear icon on a field's row to expand its settings.
3. Click the **Disable** button.

The field is immediately removed from the active display (moved to the Disabled
section) and the change is saved.
