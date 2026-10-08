# orgchart — manual setup guide

**orgchart** (`orgchart`) lets you build and publish interactive organizational
charts — the boxes‑and‑lines diagrams that show who reports to whom, or how
departments and teams fit together. You create each chart either with a visual
**drag‑and‑drop builder** (dragging and resizing boxes into place) or by editing
the chart's **YAML source** directly for precise, bulk changes. Once built, a
chart can be shown through the **Org Chart block** or on its own dedicated URL.

Charts are responsive: each one can carry multiple *displays* (for example
desktop, tablet, and phone) so the same structure is laid out appropriately at
different screen sizes. Because chart definitions are stored as Drupal
configuration, you can export them and move an org structure between environments,
or keep them under version control.

The module keeps everyday viewing separate from editing through three
permissions: **access orgchart** to view charts, **administer orgchart** to
create and manage them, and a more tightly restricted **administer orgchart yaml**
for editing the raw YAML (which is more powerful and therefore guarded). It builds
on the jQuery UI Draggable and Resizable modules for the visual editor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer along with its
   jQuery UI dependencies, and enable the module.
2. [Configuration](configuration/index.md) — set default chart options and create,
   build, and manage your charts.

## Where it lives in the admin menu

Charts are managed at **Configuration → orgchart** (`/admin/config/orgchart`),
where you'll find the listing plus add / build / edit / delete forms. The raw
YAML editor for a chart lives at `/admin/config/orgchart/yaml/{id}/{display}`.

## How to use it

Once you've built a chart (see [Configuration](configuration/index.md)), you can
display it in two ways:

- **As a block** — place the **Org Chart** block in a region via **Structure →
  Block layout** and choose which chart it shows. This is the usual way to embed a
  chart on an About or Team page.
- **On its own page** — each chart also gets a dedicated route so you can link
  straight to it.
