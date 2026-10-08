# Display Layout — manual setup guide

**Display Layout** (`display_layout`) lets you use Drupal's **Layout API** layouts
when configuring an entity's display. Normally, on a "Manage display" screen each
field can only be set to a region called *Content* or moved to *Disabled*. Display
Layout adds the ability to pick a **layout** (one‑column, two‑column, and so on) for
that view mode, giving you real **regions** to sort your fields into — without
resorting to field groups.

The problem it solves is arranging fields into a structured layout in a view mode
with minimal fuss. If you have wanted a "sidebar + main" or multi‑column
arrangement of fields on a node's display but did not want the weight of Layout
Builder or a stack of field‑group modules, this is a lightweight middle ground. The
project describes itself as a minimalist reimplementation of **Display Suite** — and
importantly, its configuration does *not* map to Display Suite, so a site should not
use both.

It depends on Drupal core's **Layout Discovery** and **Field UI** modules. It is
purely a display/site‑building feature — it changes how fields are arranged, and has
no role in content or access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.

There is **no separate settings page** for Display Layout — you configure it
directly on each view mode's **Manage display** form, described in "How to use it"
below.

## How to use it

1. Go to the **Manage display** form for a content entity — for example
   **Structure → Content types → *(type)* → Manage display**, and pick the view mode
   you want to lay out (Default, Teaser, etc.).
2. Scroll to the bottom and open the **Display layout settings** section.
3. **Select which layout** the display mode should use (for example a two‑column
   layout) and save.
4. The regions defined by that layout now appear on the same form as places you can
   drag your fields into. Sort each field into the region you want, and save again.

Your fields are now rendered inside the chosen layout's regions for that view mode.
Repeat per view mode (and per entity type/bundle) as needed.
