# Multi Value Add Hider — manual setup guide

**Multi Value Add Hider** (`multi_value_add_hider`) is a small, focused tidy‑up for
content edit forms. When a field is set to *unlimited* cardinality (an "add as many
as you like" multi‑value field), Drupal always shows an extra empty row at the
bottom, ready for another value. On forms with several such fields, those blank
"add another" rows pile up and clutter the editing experience.

This module removes that automatic empty row — **except** when the field has no
existing values yet, so an empty field still shows one row for you to fill in. The
result is a cleaner, less noisy edit form: existing values are shown, and you add a
new one deliberately rather than always staring at a spare blank row.

It depends only on core's **Field** module and affects the *widget display* on
edit forms. It has no settings form, no admin page, no routes, and no permissions,
and it plays no role in content access — it simply changes how the multi‑value
widget renders. Enable it and the behavior applies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form and nothing to
configure. Once enabled, the tidier behavior applies to unlimited multi‑value
fields automatically.

## Where it lives in the admin menu

Multi Value Add Hider adds no admin page. Its effect is visible on any content
(or entity) **edit form** that has an unlimited‑cardinality multi‑value field: the
usual trailing empty "add another" row no longer appears when the field already has
values.
