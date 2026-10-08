# Entity Reference Ajax Formatter — manual setup guide

**Entity Reference Ajax Formatter** (`entity_reference_ajax_formatter`) is a
**field formatter** for entity reference fields whose standout feature is an
**AJAX "Load more" link**. Instead of rendering every referenced entity at once,
you can render, say, the first 3, and let the visitor click **Load more** to pull
in additional references inline — without a full page reload. This is handy for
long reference lists where you want a fast initial page and progressive loading.

Like core's rendered‑entity formatter, it lets you pick the **view mode** to
render the references in, and it adds a few display‑only options on top:

- **Number** — how many entities to render initially (default 6).
- **Sort** — a few extra sorting options that affect only this display.
- **Load more** — turn the AJAX "load more" link on or off (off by default).
- **Max** — the maximum number of entities to render; `0` means all references.
  This option only appears when **Load more** is enabled.

There is **no central settings page** — everything is configured per field on
*Manage display*. The module works across Drupal 8 through 11 (10 recommended)
with no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Each
field is configured on *Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from an entity's **Manage display**, for
example **Structure → Content types → *(type)* → Manage display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open **Manage display** for the bundle that has your entity reference field.
3. In the **Format** column, choose the AJAX formatter this module provides.
4. Click the settings gear and set the **view mode**, the initial **Number** of
   entities, the **Sort** option, whether to show **Load more**, and (if Load
   more is on) the **Max** number to render.
5. Save. On the rendered page, the field shows your initial batch and — if
   enabled — a **Load more** link that fetches additional references inline via
   AJAX.
