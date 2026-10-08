<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Field Copy — manual setup guide

**Display Field Copy** (`display_field_copy`) is a small extension for
[Display Suite](https://www.drupal.org/project/ds) that solves one specific
limitation: normally you can only place a given field **once** on an entity's display.
This module lets you render the same field more than once on the same page, each copy
with its own formatter and formatter settings.

That opens up a lot of "show the same data two ways" layouts. You could show an image
field once as a large "Full" image and again as a thumbnail elsewhere, render a
taxonomy field both as linked tags and as a plain comma-separated list, display a body
field as a trimmed summary up top and the full text lower down, or output a date field
as both a compact badge and a long-form date. Crucially, a copy displays **live field
data** — it does not duplicate any storage or content, it just re-renders the original
field through a different formatter.

Each copy you create becomes a Display Suite field that shows up in **Manage display**
right alongside the original field, so you enable it, pick a formatter, and place it in
a region exactly like any other field. There is no limit on the number of copies, and
each is saved as configuration (`ds.field.*`) so it travels between environments with
the rest of your config.

There is no settings page and no permission of its own — you use it entirely through
Display Suite's field UI. Because of that, this guide folds the "how to use it"
walkthrough into this page rather than a separate configuration section.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Display Suite).

## Where it lives in the admin menu

The tool for creating copies lives under Display Suite at **Structure → Display Suite →
Fields** (`/admin/structure/ds/fields`). Each copy you make then appears in the
relevant entity's **Manage display** screen.

## How to use it

### Create a copy

1. Make sure the entity's view mode is managed by Display Suite (set this up on the
   entity's **Manage display** tab).
2. Go to **Structure → Display Suite → Fields** (`/admin/structure/ds/fields`).
3. Click **Create a copy of a field**.
4. Enter a **Label**, pick the source **Field** from the list (base fields and
   configured fields across your content entity types are offered), and save. This
   requires the *Administer fields* permission.

### Place and format the copy

1. Go to the source entity's **Manage display** — for example
   `/admin/structure/types/manage/article/display`.
2. The new copy now appears there as a Display Suite field. Enable it, choose any
   **formatter** valid for that field's type, adjust its settings, and drop it into a
   region.
3. Save the display. The field now renders in two (or more) places, each with its own
   formatting.

Repeat the process to add as many copies of a field as your layout needs. To remove a
copy, delete it from the Display Suite Fields list.
