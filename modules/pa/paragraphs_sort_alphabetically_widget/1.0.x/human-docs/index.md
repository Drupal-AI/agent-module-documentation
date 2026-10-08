# Sort Alphabetically Widget — manual setup guide

**Sort Alphabetically Widget** (`paragraphs_sort_alphabetically_widget`) is a
small collection of field widgets that keep a multi‑value field's entries sorted
alphabetically (A→Z) in the edit form. If you have a reference field where the
order of the values does not matter for meaning but you want it tidy and
predictable, this widget takes care of the ordering for you rather than leaving
it to whatever sequence things were added in.

Despite the "paragraphs" in its project name, it provides a few simple widget
variants that add an alphabetical‑sort option to reference‑style fields —
including the Paragraphs (Stable) and Paragraphs (Legacy) widgets and an
autocomplete widget. It only affects the *ordering shown while editing*; it does
not change what is stored beyond the order, and it has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
switch it on per field from the field's form display, described in "How to use
it" below.

## How to use it

The widget is selected on a field's **Manage form display**:

1. Go to **Structure → Content types → *(your type)* → Manage form display**
   (or the equivalent Manage form display for any other fieldable entity or
   paragraph type).
2. Find the multi‑value field you want kept in alphabetical order.
3. In that field's **Widget** column, choose the matching "sort alphabetically"
   widget variant provided by this module.
4. Save the form display. When editors work with that field, its values are kept
   sorted A→Z.
