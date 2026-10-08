# BPMN.iO Modeler — manual setup guide

**BPMN.iO Modeler** (`bpmn_io`) brings the well‑known JavaScript **bpmn‑js** diagram
editor into Drupal's admin UI, giving you a graphical, drag‑and‑drop canvas for
building process models — most commonly **ECA** models and **AI Agents**. Instead of
editing a process as a table of rows, you drag start events, tasks, gateways and
sequence flows onto a canvas, wire them together, and configure each element in an
off‑canvas properties panel.

It is not a standalone tool: BPMN.iO is a **Modeler plugin** for the **Modeler API**
framework. Any module that acts as a Modeler API "model owner" (notably ECA and AI
Agents) can then render and edit its configuration entities as a visual BPMN diagram,
reusing that owner's own configuration forms inside the properties panel. Diagram data
is stored as standard BPMN 2.0 XML, and the module can convert an existing model that
was built without a diagram into a laid‑out one.

The canvas comes with a toolbar (info, auto‑layout, download SVG, copy/paste, zoom,
search, minimap). The module has **no admin settings form, no permissions, and no
configuration of its own** — you enable it and then select it as the modeler from a
model‑owner module. One important constraint: it only works under the **Claro** or
**Gin** admin theme (or a subtheme of them).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside a model‑owner module such as ECA or AI Agents).

## Where it lives in the admin menu

BPMN.iO has no page of its own. It surfaces wherever a model‑owner module renders its
models — for example, ECA's model editor or the AI Agents editor. Once BPMN.iO is
enabled and selected as that owner's modeler, opening a model shows the graphical
BPMN canvas instead of the fallback table‑based UI.

## How to use it

1. Make sure you're using the **Claro** or **Gin** admin theme — the modeler will not
   render under other themes.
2. Enable a **model‑owner** module (such as ECA or AI Agents) along with BPMN.iO.
3. In that owner's settings, **select `bpmn_io` as the modeler** (owners that support
   multiple modelers let you choose; with only one installed it's used by default).
4. Open or create a model. You get the drag‑and‑drop canvas: add start events, tasks,
   gateways and sequence flows; click any element to open its properties panel and
   configure it using the owner's own forms; use the toolbar to auto‑layout, zoom,
   search, copy/paste, or download the diagram as SVG.

If you maintain a custom admin subtheme that should also be allowed, a module can
whitelist it via `hook_bpmn_io_supported_themes_alter()`.
