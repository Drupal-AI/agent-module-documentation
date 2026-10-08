# Bootstrap Layout Classes — manual setup guide

**Bootstrap Layout Classes** (`bootstrap_layout_classes`) lets editors pick
Bootstrap grid and utility classes on a field, instead of hand-typing class names
into markup. It provides a **field widget** (the control an editor uses to choose
classes — columns, spacing, and similar) and a matching **field formatter** (which
outputs the chosen classes when the content is displayed).

The idea is to drive Bootstrap-based layout from content. An editor selects the
layout options they want per item; the module stores that choice and emits the
corresponding Bootstrap classes, so nobody has to remember or spell out class
strings like `col-md-6` by hand. It depends on core's Field module, and it only
affects output classes — it does not change data access or permissions.

This is most useful on Bootstrap-themed sites where content authors are expected
to influence layout without touching templates or CSS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. You use the module per field, under
**Structure → Content types → (your type) → Manage form display** (to set the
widget) and **Manage display** (to set the formatter).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Add or pick a field on a content type (or other fieldable entity) that should
   carry layout classes.
3. Under **Manage form display**, choose this module's **class-selection widget**
   for that field, so editors get a control for picking Bootstrap classes.
4. Under **Manage display**, choose this module's **formatter** so the selected
   classes are output when the content renders.
5. Use a Bootstrap-based theme so the emitted grid/utility classes actually mean
   something in the rendered page.
