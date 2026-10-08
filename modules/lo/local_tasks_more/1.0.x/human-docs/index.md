# Local Tasks More — manual setup guide

**Local Tasks More** (`local_tasks_more`) tidies up the row of local task tabs —
the *View / Edit / Layout / Revisions / Translate…* links — that Drupal shows at
the top of content and admin pages. On a busy node those tabs can pile up
(Usage, Clone, Devel, Convert, and more), pushing the everyday links out of
sight. This module hides the less‑used ones behind a **"show more / show less"
toggle** so the important tabs stay front and centre, and lets you rename,
re‑order, or remove individual tabs.

Out of the box the toggle is applied only to nodes (the `entity.node.canonical`
route), and the node **Delete** tab is hidden. The toggle itself is not
JavaScript‑only: the module adds the show‑more link, its icon, and the needed CSS
classes in PHP (via `hook_menu_local_tasks_alter()` and
`hook_preprocess_menu_local_task()`), so it behaves reliably. The toggle icon is
an inline SVG whose colour you can restyle in CSS
(`.local-tasks-more-toggle svg path { fill: blue; }`).

It works with any front‑end or admin theme that renders local tasks from Drupal
core's default templates (`menu-local-tasks.html.twig` and
`menu-local-task.html.twig`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module. Its behaviour (which routes get
the toggle, and which tasks are hidden, renamed, or re‑weighted) is defined in
the module's shipped configuration rather than an admin form — see "How to use
it" below.

## Where it lives in the admin menu

Local Tasks More adds no admin page of its own. Once enabled, the "show more"
toggle simply appears on the local‑task tab row of the affected routes (nodes, by
default). Enable it and view any content page as an editor to see it in action.

## How to use it

The module ships sensible defaults, so for most sites there is nothing to do
beyond enabling it: view a node and you'll see the everyday tabs, with the rest
collapsed behind **Show more**. If you want to change which routes get the
toggle, alter a task's title or weight, or hide a specific tab, that is done
through the module's configuration (it ships a config schema for exactly this).
