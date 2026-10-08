# Paragraph SDC — manual setup guide

**Paragraph SDC** (`paragraph_sdc`) is a bridge between your existing Drupal content
and **Single Directory Components (SDC)** — Drupal's component system — with a
particular eye on **Drupal Canvas**. If you have invested years building a rich
library of paragraph types, moving to Canvas can feel like starting over, because
Canvas builds pages from components rather than paragraphs. Paragraph SDC lets you
reuse what you already have: any existing paragraph (or other entity) becomes
Canvas‑ready without being rebuilt.

It provides three main capabilities:

- **Instant content reuse in Canvas.** Drag the *Paragraph SDC* component onto a
  Canvas page, pick an entity type and view mode from friendly dropdowns, enter an
  entity ID, and your content appears immediately. Supported entity types include
  paragraph, node, user, taxonomy term, comment, file, block content and contact
  form; view modes include full, teaser, RSS, search index and search results. A
  companion *Entity SDC* component offers the same idea with free‑form text inputs
  for developers who need to reference custom entity types and view modes.
- **Contextual editing (new in v2.0).** In Canvas preview mode a small **pencil
  icon** appears on rendered content; click it to open the original source content
  for editing in a new tab — the see‑it‑then‑edit‑the‑original workflow editors
  expect.
- **The reverse direction: SDCs as paragraphs.** A dedicated *SDC* paragraph type
  lets you place any Single Directory Component on traditional, non‑Canvas
  paragraph‑based pages, passing custom properties via JSON. No code changes
  required.

Version 2.0 also adds `/paragraph/{id}` and `/paragraph/{id}/edit` routes, giving
paragraphs the same URL patterns as other first‑class entities, and it supports
using the components directly in **Twig templates** (for example
`{% include 'paragraph_sdc:paragraph-sdc' with { id: 12345 } %}`).

Everything here is theme‑layer/component integration: the components render
access‑controlled paragraph and entity field data, so there is no security surface of
its own. It depends on the **Paragraphs** and **Twig Tweak** modules (plus Drupal
Canvas for the Canvas features), and is marked as receiving maintenance fixes only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Paragraphs /
   Twig Tweak dependencies and enable it.

There is **no settings form** for this module. You use it through Drupal Canvas, the
SDC paragraph type, or Twig — described below.

## Where it lives in the admin menu

Paragraph SDC adds no settings page. Its components appear inside the **Drupal
Canvas** editor (under "Other" in the component library) and as an **SDC paragraph
type** you add like any other paragraph. It also registers `/paragraph/{id}` and
`/paragraph/{id}/edit` routes for viewing and editing paragraphs directly.

## How to use it

**In Drupal Canvas:**

1. Install and enable Paragraph SDC with Paragraphs and Twig Tweak (see
   [Installation](installation/index.md)), and rebuild the cache.
2. Click **Edit** to open the Canvas editor and find **Paragraph SDC** under
   "Other" in the left sidebar.
3. Drag it onto the page, then in the Properties panel set the **Entity Type** (for
   example *paragraph*), the **View Mode** (for example *full*), and enter the
   entity **ID**. Your content renders on the canvas.
4. Switch to **Preview** mode and click the **pencil icon** on any rendered content
   to edit the original in a new tab.

**As an SDC paragraph (no Canvas):** add the **SDC** paragraph type to a paragraph
field, choose which Single Directory Component to render, and pass any custom
properties as JSON.

**In Twig:** include a component directly, e.g.
`{% include 'paragraph_sdc:entity-sdc' with { entity_type: 'node', id: 67890 } %}`.
