# Entity Reference Tab Formatter — manual setup guide

**Entity Reference Tab Formatter** (`entity_ref_tab_formatter`) is a **field
formatter** that renders a multi‑value entity reference field as an **accessible
tabbed interface or accordion** — each referenced entity becomes a tab (or an
accordion panel). It works with both `entity_reference` and
`entity_reference_revisions` fields, so it pairs especially well with
**Paragraphs**, but works with any referenced entity type.

You can switch between **Tabs** and **Accordion** layouts at any time without
touching your stored data. Tab/panel titles can be mapped to any field on the
referenced entity, falling back to the entity label when that field is empty.
Each panel's body can render a **single field**, the **full referenced entity**
(in a view mode you pick), or a **Views block display** (with optional contextual
filter arguments). The accordion mode has its own options — single vs. multiple
open panels, header color and width, and icon alignment.

The formatter is built on Drupal core's `once()` with **no jQuery UI dependency**,
and its markup is accessible with sensible keyboard defaults — the first panel
stays visible even before JavaScript loads. There is **no central settings page**:
everything is configured per field on *Manage display*. It works on Drupal 10 and
11 with no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Each
field is configured on *Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from an entity's **Manage display**, for
example **Structure → Content types → *(type)* → Manage display** (or a Paragraph
type's Manage display).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open **Manage display** for the entity that has your reference field (for
   example a Paragraph reference field on a content type).
3. In the **Format** column, choose **Entity reference tab formatter**.
4. Click the settings gear and adjust:
   - **Tab title field** — the referenced field to show in each tab/accordion
     header; falls back to the entity label if left empty.
   - **Tab body field** — choose a specific field, a **Views block** (then pick
     the block display and optional comma‑separated contextual arguments), or
     **Rendered entity (full view)**.
   - **Rendered entity view mode** — when rendering the full entity, pick the view
     mode configured under **Structure → *(bundle)* → Manage display**.
   - **Display style** — toggle **Tabs** vs. **Accordion**, and set the accordion
     options (single or multiple open panels, header color, full‑width header,
     icon alignment).
5. Save, and clear caches if the change doesn't appear immediately.
