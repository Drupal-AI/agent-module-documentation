# Entity Reference Display — manual setup guide

**Entity Reference Display** (`entity_reference_display`) lets a content editor
choose *how* a referenced entity is rendered — for example as a `teaser` on one node
and `full` on another — instead of a site builder fixing that choice once for the
whole field.

Normally, when you place an entity reference field on Manage display, you pick a
single view mode and every reference on every piece of content renders that way.
This module moves the choice to the editor. You add its **Display mode** field
(field type `entity_reference_display`) to a bundle; it stores one view‑mode machine
name (`default`, `teaser`, `full`, …) as an ordinary string value. Then you place its
companion **Selected display mode** formatter on the actual entity reference field.
At render time the formatter reads the display‑mode field's value off the same entity
and renders the referenced entities with it.

The field presents its choices through core's Options widgets (a select list by
default, or radio buttons), so there is no extra widget to maintain. Its field
settings let you **exclude** view modes you do not want editors to pick, or flip
`negate` to turn that list into an allow‑list of the only modes offered. Cardinality
is fixed to one choice per field, and if Entity Reference Revisions (Paragraphs) is
installed the formatter transparently switches to a revisions‑aware variant.

This module has **no admin settings page** — everything is configured per field on a
bundle. This guide is written for a **human** clicking through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no global configuration; you set everything up per field. There are two
pieces, both added on the bundle (content type, paragraph type, media type, …) that
holds your entity reference field:

1. **Add the Display mode field.** On the bundle's **Manage fields**, add a new field
   of type **Display mode** (category *Reference*). Its storage is a single string
   and its cardinality is locked to one. Choose the **Text area with a select list**
   default widget (`options_select`), or switch to radio buttons (`options_buttons`)
   on **Manage form display**.
   - In the field's settings you can list view modes under **Exclude** to hide them
     from the editor's choices. Tick **Negate** to flip that into an allow‑list — only
     the listed modes are then offered. The options are all the view modes defined on
     the site (deduplicated, alphabetical) with **Default** at the top.

2. **Put the formatter on the reference field.** On the bundle's **Manage display**,
   set your entity reference field's format to **Selected display mode**. (This
   format only appears when the bundle already has at least one Display mode field.)
   - If the bundle has more than one Display mode field, the formatter's
     **Display field** setting lets you pick which one drives it. With only one, it is
     used automatically.
   - The rendered field wrapper gets a `erd-list--<view_mode>` CSS class so you can
     style items differently per selected mode.

Now, when an editor creates or edits content, they pick a display mode from the
select list, and the referenced entities render with exactly that mode.
