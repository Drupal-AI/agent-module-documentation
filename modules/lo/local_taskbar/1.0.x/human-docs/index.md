# Local Taskbar — manual setup guide

**Local Taskbar** (`local_taskbar`) restyles Drupal's **local tasks** — the
primary and secondary action tabs (*View*, *Edit*, *Delete*, and so on) — by
giving the local-tasks block its own dedicated template and theme suggestion. The
idea is to move those tasks to an easy-to-find, consistent place (the module's
design puts them in a taskbar) and to give theme developers a clean, targeted way
to style them.

The module is intentionally tiny. It registers a `block__local_tasks_block` theme
hook that points at its own Twig template
(`templates/block--local-tasks-block.html.twig`), adds that template as a theme
suggestion for any block using the `local_tasks_block` plugin, and exposes the
tab content and a fresh attributes object to the template through a preprocess
hook. It also ships a Single Directory Component under
`components/local_taskbar/` as a rendering reference.

There is **no configuration form, route, permission, or service** — enabling the
module simply changes how the tabs render. Security-wise there is nothing to lock
down: it only renders the standard local-task links a user already has access to,
so it adds no attack surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — this module has no settings. You customise
its look by overriding its template in your own theme, described below.

## How to use it

1. **Enable the module** (see Installation). The local tasks immediately begin
   rendering through the module's template.
2. **Make sure a Tabs / local tasks block is placed** in a region. If your theme
   already shows local tasks, there is nothing to do; otherwise place the "Tabs"
   block at **Structure → Block layout**.
3. **Style it in your theme.** To customise the markup, copy the module's
   `block--local-tasks-block.html.twig` into your theme as a starting point and
   override it — the `block__local_tasks_block` theme suggestion targets exactly
   this block. Add your CSS through your theme's libraries. You can also style the
   primary and secondary tabs differently using this dedicated template.

## Removing it

If you remove the module, the tabs simply fall back to Drupal's default local-task
rendering.
