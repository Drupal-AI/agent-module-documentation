# IEF Complex Open — manual setup guide

**IEF Complex Open** (`ief_complex_open`) is a small editorial‑UX tweak for the
**Inline Entity Form** module. Inline Entity Form's *Complex* widget lets content
editors add referenced entities right inside the parent form; this module adds a
variant of that widget whose **"Add existing" autocomplete field is already open**
the moment the form loads.

That saves a step in the common workflow of referencing content that already
exists: instead of clicking a button to reveal the autocomplete and *then*
typing, the editor can start typing straight away. It also makes the experience
feel closer to core's own entity autocomplete widget. It's a change to the form's
initial state only — it doesn't affect what can be referenced or who may edit it.

The module depends on the **Inline Entity Form** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no settings form** — you enable it and then select its widget
on a field, described below.

## Where it lives in the admin menu

IEF Complex Open adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage form display**, by choosing its widget for an entity
reference field.

## How to use it

1. Edit the content type that has an entity reference to other content and open
   its **Manage form display**.
2. For the reference field, change the widget to **Inline entity form - Complex
   (Open)**.
3. Save. Now when editors create or edit that content, the "Add existing …"
   autocomplete field is open and ready for input by default.
