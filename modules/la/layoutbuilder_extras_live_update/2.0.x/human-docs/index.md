# Layout Builder extras - live update — manual setup guide

**Layout Builder extras - live update** (`layoutbuilder_extras_live_update`) adds
UI/UX tweaks to
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder), the
headline one being a **live‑updating preview**: when you change a setting on a
Layout Builder section, the layout updates immediately so you can see the result
without pressing **Save**. Think of it as quick‑edit, but in the mindset of Layout
Builder.

In this **version 2** the live‑update behavior is focused on **sections**. When you
change a section setting — for example a color, a background, or another option —
the layout redraws on the spot. The live updating currently applies to
**radios, radio, select, checkbox, and checkboxes** controls on the section form;
support could be expanded to more field types if needed. (Version 2 dropped the
earlier live updating of block content in favor of a cleaner, Drupal 11‑ready
codebase.)

One important operational note carried over from the project: this module currently
**requires a core patch** to function — "Allow to merge AjaxCommands in
AjaxResponse" (Drupal.org issue #3343670). Apply that patch to
`drupal/core-recommended` before relying on the live‑update behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, apply the
   required core patch, and enable the module.
2. [Configuration](configuration/index.md) — the settings form and the permission
   the module provides.

## Where it lives in the admin menu

The module provides a settings form at the route
`layoutbuilder_extras_live_update.settings_form`. In most cases the module is
install‑and‑go — once enabled (and with the core patch applied), the live updating
works. See [Configuration](configuration/index.md) for the form and permission.

## How to use it

1. With the module enabled and the core patch applied, open a Layout Builder‑enabled
   entity in the editor.
2. Configure a **section** and change one of its supported controls — a set of
   radios, a select list, or a checkbox.
3. The layout preview updates immediately to reflect the change, before you save.
