# Layout Builder Save And Edit — manual setup guide

**Layout Builder Save And Edit** (`layout_builder_save_and_edit`) adds a second
button — **"Save and edit layout"** — to Drupal's Layout Builder forms. The stock
"Save layout" button saves your work and then *exits* the Layout Builder session,
which is disruptive when you are building a complex layout and want to save a
checkpoint and keep arranging blocks. This module's button saves and then returns
you right back to the same layout‑editing page, so you never lose your place.

The button appears in three places: on a display's **default layout** form (for
example a content type's layout defaults), on an individual entity's **layout
override** form (the Layout Builder canvas), and on a content entity's add/edit
form when that entity has an editable Layout Builder override field. In every case
the original "Save layout" button is left untouched, so you keep both behaviours
side by side — "save and exit" and "save and keep editing."

The module is deliberately tiny: it is a single form alteration with **no
configuration, no routes, no permissions, and no settings of its own**. It works
site‑wide the moment you enable it. On content entity forms the button only shows
for users who already hold Layout Builder's per‑bundle "configure editable …
layout overrides" permission, so it respects existing access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — the module has no admin page. Its effect is the extra **Save and edit
layout** button that appears next to the usual **Save layout** button on Layout
Builder forms and on Layout‑Builder‑enabled content edit forms.

## How to use it

Enable the module and open any Layout Builder canvas (for a content type's default
layout or an individual entity's override). Alongside **Save layout** you will now
see **Save and edit layout**. Click it to save your changes and land right back on
the same layout page to keep working. There is nothing to configure. On content
edit forms the button appears only when you have permission to configure that
bundle's layout overrides.
