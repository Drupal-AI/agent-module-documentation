# Jquery UI Field — manual setup guide

**Jquery UI Field** (`jqueryui_field`) is a small field type for building tabbed
or accordion content. Each value you enter is a **label / description pair** — a
heading and its body text — and the field then renders the whole set as either
**jQuery UI Tabs** or a **jQuery UI Accordion** on the display side. It's a
lightweight way to let editors create FAQ‑style accordions or tabbed panels
without any custom code.

You work with it entirely through Drupal's normal field system. Add the field to
any content type (or other fieldable entity), let editors fill in the label and
description for each item, then pick how it displays on the bundle's **Manage
display** page.

The module has **no configuration UI of its own** — there's no settings page.
Everything is set up per field, on the standard Field UI screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up on your field's Manage display, described in "How to use it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   equivalent for another entity type).
2. Click **Add field** and choose the **Jquery UI Field** field type. Set its
   cardinality to more than one value if you want multiple tabs/accordion panels.
3. When editing content, fill in a **label** and **description** for each item —
   each pair becomes one tab or accordion section.
4. On the bundle's **Manage display** page, set the field's format to one of the
   two provided formatters:
   - **Jqueryui Tabs** — renders the items as a horizontal set of tabs.
   - **Jqueryui Accordion** — renders the items as a vertical, expand/collapse
     accordion.
5. Save the display. The field now shows as interactive tabs or an accordion on
   the rendered entity.
