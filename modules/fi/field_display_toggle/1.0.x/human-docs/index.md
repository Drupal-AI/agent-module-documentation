# Field Display Toggle — manual setup guide

**Field Display Toggle** (`field_display_toggle`) adds a pair of one‑click radio
buttons — **Enable all fields** and **Disable all fields** — to the *Manage
display* screen of any entity. On entities with many fields, configuring a view
mode that should show only a handful of them means dragging every other field
down into the *Disabled* region by hand. This module lets you flip the whole set
at once and then reposition only the few you care about.

Choosing **Disable all fields** moves every field into the *Disabled* region;
choosing **Enable all fields** moves them all back into the visible content
region. It is a small but real time‑saver when you build several view modes
across content types that each expose a different, small subset of fields.

This is a site‑building convenience that affects display configuration only. It
adds no fields, no content, and no permissions, and it needs no configuration of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — the toggle appears directly
on the *Manage display* form, described below.

## Where it lives in the admin menu

Field Display Toggle adds no admin page of its own. The toggle lives on the
existing display form: **Structure → Content types → *(type)* → Manage display**
(`/admin/structure/types/manage/{type}/display`). The same **Enable all
fields** / **Disable all fields** radios appear on the Manage display form for
other fieldable entity types too.

## How to use it

1. Go to **Structure → Content types → *(type)* → Manage display** (or the
   equivalent Manage display screen for another entity type or view mode).
2. Use the **Enable all fields** / **Disable all fields** radio buttons at the
   top to move every field into the content region or the disabled region in one
   action.
3. Drag the few fields you want to reposition, set their formatters, and adjust
   order as usual.
4. Click **Save**.
