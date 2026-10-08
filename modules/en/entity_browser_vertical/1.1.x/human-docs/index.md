# Entity Browser Vertical — manual setup guide

**Entity Browser Vertical** (`entity_browser_vertical`) is a small add‑on for the
Entity Browser module. It adds one new display option — **"Entity label, stacked
vertically"** — so that items an editor selects through an Entity Browser widget
appear in a vertical, drag‑to‑reorder list instead of the default side‑by‑side row
of chips.

The default horizontal layout works fine for a handful of items, but it becomes hard
to scan (and can overflow) when a field references many entities or when their titles
are long. This module puts each referenced item on its own row with a drag handle,
which makes a long selection easier to read and reorder — much like a lightweight
tabledrag list.

It is deliberately minimal: it ships a single display plugin and nothing else. There
is **no settings form, no permissions, and no Drush** — you switch a field to the
vertical layout by choosing this display on the field's Entity Browser widget, and
that choice is stored as an ordinary widget setting in your form display
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module has no page of its own. You enable the vertical layout per field under
**Structure → (content type) → Manage form display** (the Field UI), on a field that
uses the Entity Browser widget.

## How to use it

1. Go to the entity's **Manage form display** — for example
   `admin/structure/types/manage/article/form-display`.
2. Find the entity‑reference field you want, and make sure it uses the **Entity
   browser** widget. Click the widget's cog/gear to open its settings.
3. Set the **Entity display plugin** to **"Entity label, stacked vertically"**.
4. Click **Update**, then **Save**.

The field's current selection now renders as a vertical list with a drag handle on
each row, so editors can reorder items by dragging. Switching the display plugin back
to another value (such as the plain label) returns it to the default horizontal
layout. You can apply this per form mode, so a field can use the vertical layout on
one form and the default on another.
