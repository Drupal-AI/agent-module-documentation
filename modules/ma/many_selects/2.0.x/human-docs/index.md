# Many Selects — manual setup guide

**Many Selects** (`many_selects`) replaces the browser's native multi-select box
with a friendlier widget for multi-value option fields. The standard
`<select multiple>` control is notoriously awkward: you have to Ctrl/Cmd-click to
pick more than one option, a single stray click without the modifier key wipes
the whole selection, and on touch devices it's close to unusable. Many Selects
takes a different approach — it renders a series of ordinary **single-select
dropdowns**, one per chosen value, so each choice is independent and no click can
accidentally destroy the others.

It's the actively maintained Drupal 8+ successor to the old Drupal 7 "Multiple
selects" module. Core's `options` module offers checkboxes as an alternative to
the native multi-select, which is fine until the list runs to hundreds of values;
Many Selects stays workable for long option lists and lets editors add values one
at a time. Crucially, it changes only the **editing widget** — your field type
and stored data model stay exactly the same, so you can switch to it (or away from
it) without touching your data.

It depends on core's **Options** module, needs PHP 8.1+, and has **no
configuration of its own** — you simply choose it as the widget on a field's form
display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — no settings form and no
permissions. You enable the widget per field, as described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page. You select its widget from **Structure → Content
types → *(your type)* → Manage form display** (or the equivalent *Manage form
display* tab for any other fieldable entity).

## How to use it

1. Add or pick a **multi-value option field** (an Options list / list field set to
   allow more than one value).
2. Go to that bundle's **Manage form display**.
3. For the field, change the widget to **Many select list(s)**.
4. Open the widget's settings (the gear icon) to configure it, then save.

Content editors will now add each value through its own dropdown instead of
wrestling with a native multi-select — with no change to how the values are
stored.
