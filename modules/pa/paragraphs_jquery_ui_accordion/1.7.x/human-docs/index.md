# Paragraphs jQuery UI Accordion — manual setup guide

**Paragraphs jQuery UI Accordion** (`paragraphs_jquery_ui_accordion`) adds a field
formatter that turns a multi‑value Paragraphs reference field into a collapsible
**jQuery UI accordion**. Each referenced paragraph becomes an accordion panel: one
of the paragraph's fields supplies the clickable header, and another supplies the
body that expands and collapses. It's a no‑code way to build FAQs, feature lists,
terms‑and‑conditions sections, "how it works" steps, pricing tiers, and any other
content that reads better as expandable panels.

Because it works entirely through a display formatter, editors just keep adding
paragraphs the way they already do — you switch the field's display to the accordion
formatter once, and every entity built from it renders as an accordion. There is no
custom JavaScript to download: the module reuses Drupal core's bundled jQuery UI
Accordion (via the `jquery_ui_accordion` contrib module).

The module has **no settings page and no permissions of its own** — everything is
configured in the field formatter settings on an entity's *Manage display* screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Paragraphs.

## Where it lives in the admin menu

It has no admin page. You reach its only options on the **Manage display** tab of
whichever entity holds your multi‑value paragraph field — for example
**Structure → Content types → Page → Manage display**.

## How to use it

The formatter only appears for a field that is a **multi‑value** paragraph
reference (`entity_reference_revisions` targeting the `paragraph` entity type). Once
you have such a field:

1. Go to the entity's **Manage display** tab.
2. For that field, choose the **Paragraphs jQuery UI Accordion** formatter.
3. Open the formatter settings (the gear icon) and configure:
   - **Paragraph bundle** — which paragraph type the formatter reads.
   - **Title field** — the field on that bundle used as each panel's **header**
     (read as a plain value).
   - **Content field** — the field used as the collapsible **body**.
   - **View mode** — the view mode used to render the body field (default
     *Default*).
   - **Active** — open the first panel by default, or leave all panels closed.
   - **Simple id** — use sequential numeric ids (1, 2, 3…) for the panels instead of
     ids derived from the header text; handy when you need predictable element ids.
   - **Autoscroll** — scroll the opened panel into view. Pair it with an
     **autoscroll offset** (a pixel value) so an opened panel isn't hidden behind a
     fixed header, and optionally apply that offset **only for users who see the
     admin toolbar**.
4. Save. Your paragraph field now renders as an accordion.

Make sure the paragraph bundle you pick actually has the header and body fields you
select in the formatter.
