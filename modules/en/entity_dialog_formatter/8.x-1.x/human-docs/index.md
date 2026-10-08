# Entity Dialog Formatter — manual setup guide

**Entity Dialog Formatter** (`entity_dialog_formatter`) is a field formatter for
**entity reference fields** that opens the referenced entity in a **dialog (modal)**
instead of sending the visitor to a separate page. On the page you show the entity
in one view mode (say a teaser or a preview image); when a visitor clicks it, a
modal pops open showing the entity rendered in another view mode (say the full
content). It's a clean way to give quick, in‑context detail without a full page load.

The whole thing is built on **Drupal core's modal dialog** — it needs no extra
JavaScript library, and because the dialog comes from core it is fully accessible.
Common uses include showing an article as a teaser and opening the full article in a
modal, opening a video in a modal from a preview image, or building a gallery where
clicking a thumbnail opens the full‑size image. You can also configure the formatter
to display **all** the referenced entities together in the dialog.

It's configured on a field's **Manage display** — there's no separate settings page.
Both the on‑page view mode and the in‑dialog view mode are configurable there. The
referenced entity is rendered **respecting its own access** (only entities the
viewer may see are shown in the dialog), so the formatter adds no access risk of its
own. It depends on core **Field** and provides its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — you set everything up on the reference field's
**Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

Entity Dialog Formatter adds no admin page. You use it from **Structure → (your
entity type) → Manage display**, on an entity reference field.

## How to use it

1. Go to the **Manage display** tab for the bundle that has the entity reference
   field.
2. Set that field's format to the **dialog/modal** formatter this module provides.
3. Open the formatter settings (the gear icon) and choose:
   - the **view mode used on the page** (for example *Teaser* or a preview image),
   - the **view mode used inside the dialog** (for example *Full content*),
   - and, if you want, the option to render **all** referenced entities in the
     dialog.
4. Save the display. Clicking a referenced entity now opens it in an accessible
   core modal.
