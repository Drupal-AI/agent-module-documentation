# Base Field Display — manual setup guide

**Base Field Display** (`base_field_display`) makes an entity's **base fields**
available in the **Manage display** UI. Base fields are the built-in fields every
node has — things like the created date, the author, and the sticky flag — and
core normally hides them from the display configuration screen. This module
surfaces them there, so you can arrange and format them in your view modes just
like the configurable fields you added yourself.

In practice that means you can drag the "authored on" date or the author into the
order you want, give it a formatter, and show or hide it per view mode, all
through the UI — no custom preprocessing or template code needed. Base-field
values still follow normal field access, and the module adds no access-control
behaviour of its own.

It requires **PHP 8.0**, depends on core's **Path** module, and runs on Drupal 9,
10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives / how to use it

There is no settings page of its own. The whole feature shows up inside the
normal display configuration:

1. Go to **Structure → Content types → (your type) → Manage display** (or the
   Manage display screen for another entity type).
2. You will now see the entity's base fields (created, author, sticky, and so on)
   listed alongside your configurable fields.
3. Drag them into the order you want, pick a formatter, and set them to a region
   or to **Hidden** per view mode, then **Save**.

That is all there is to it — the base fields behave like any other field row from
that point on.
