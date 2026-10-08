# Link Field Display Mode Formatter — manual setup guide

**Link Field Display Mode Formatter** (`link_field_display_mode_formatter`) is a
formatter for core **Link** fields that, instead of printing plain link text or a
URL, renders the **current entity** in another **display (view) mode** *inside* the
link. In practice it turns a link into an embedded rendering — for example, wrapping
a teaser or card view of the entity in the link's `<a>` tag.

Its original use case is elegant: with **menu item content** fields, you can render
an icon (from another view mode) alongside a menu item. The formatter can also be
configured to render the fields **inline** (CSS `display: inline`). It reuses view
modes you already have, so you can repeat fields and reuse displays without extra
dependencies — it relies only on core Link.

Rendering the entity through another view mode carries a natural risk of infinite
loops, so the module includes **protection against recursive rendering**, just like
core's entity‑reference formatter. (It does not stop you from *selecting* the same
display mode you are currently configuring, so avoid pointing a mode at itself.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no central settings page**. You configure it per field on the
display screen, described in "How to use it" below.

## How to use it

1. On a bundle that has a **Link** field, go to **Manage display**.
2. In the **Format** column for that field, choose the **Link Field Display Mode
   Formatter**.
3. In the formatter settings, pick the **view mode** used to render the entity
   inside the link, and optionally enable the **inline** rendering option. Avoid
   choosing the same display mode you are currently editing.
4. Save the display. The link now renders the entity in the chosen view mode.
