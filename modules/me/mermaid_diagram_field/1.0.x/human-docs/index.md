# Mermaid Diagram field — manual setup guide

**Mermaid Diagram field** (`mermaid_diagram_field`) adds a new field type that lets
editors write [Mermaid](https://mermaid.js.org/) diagram code — flowcharts,
sequence diagrams, class/ER/state diagrams, Gantt charts, pie charts — and have it
rendered on the page as an interactive, pan‑and‑zoom SVG. The diagram source is
stored as plain text in a normal field, so it is easy to edit, version, and
translate; the actual drawing happens in the browser when the page loads.

Each diagram item holds a **title** (a heading above the chart), the **diagram**
code itself, an accessible **caption**, and an optional **key** (a second, smaller
diagram used as a legend). Two per‑item switches let you expose the raw code in a
collapsible panel (handy for copy‑and‑paste) and offer a "Download diagram" button
that saves the source as a `.mermaid` file. On the display side the field can show
the diagram inline, or render a link that opens it in a Drupal modal dialog. The
module also registers a reusable `mermaid_diagram` Twig theme hook so developers
can render a diagram straight from a custom render array. The Mermaid and
svg‑pan‑zoom JavaScript libraries load from the jsDelivr CDN by default, and can be
self‑hosted by overriding the library definitions.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module has **no global settings page**. (The `.info.yml` file lists a configure
link, but that route does not actually exist in this version, so ignore any
"Configure" link that appears next to the module — it does not resolve.) Everything
is configured at the field level:

- Add the field on a bundle's **Manage fields** screen
  (*Structure → Content types → [type] → Manage fields → Add field*), choosing the
  **Mermaid diagram** field type.
- Choose and tune the input widget on **Manage form display**.
- Choose the **Mermaid diagram** formatter and its options on **Manage display**.

## How to use it

1. **Add the field.** On any fieldable entity (content type, media type, taxonomy
   vocabulary, etc.) add a field of type **Mermaid diagram**. You can make it a
   multi‑value field if an entity needs several diagrams.
2. **Author a diagram.** On the entity's edit form the widget shows plain text
   inputs: a **Title**, the **Diagram** code (this is where the editor pastes or
   writes Mermaid source such as `flowchart LR\n  A --> B`), an optional **Key**
   diagram, and a **Caption**. The caption is required and is what screen‑reader
   users hear, so describe the diagram in words. Two checkboxes let the editor
   **show the code** in a collapsible pane and **allow downloading** the source.
3. **Choose how it displays.** On **Manage display**, the **Mermaid diagram**
   formatter has three settings:
   - **Display in modal** — when off (the default) the diagram renders inline on the
     page; when on, the page shows a link that opens the diagram in a modal dialog.
   - **Modal link text** — the wording of that link (defaults to *View diagram*).
   - **Extra settings** — a box of raw JSON that is passed straight to Mermaid's
     initialiser. Use it to set things like `{"theme":"dark"}` or a `securityLevel`.
     Because this JSON applies to every diagram in that display, treat it as a
     trusted, admin‑level setting — do not lower the security level if untrusted
     users author the diagram source.
4. **Save and view.** When the page loads, the module's JavaScript reads each
   diagram's text and renders it to an SVG, then attaches zoom/pan controls so
   large charts can be explored comfortably.

**Rendering a diagram from code.** Developers can render a diagram without a field
by building a render array with `#theme => 'mermaid_diagram'` (passing `#title`,
`#mermaid`, `#caption`, and optionally `#key`, `#show_code`, `#allow_download`) and
attaching the `mermaid_diagram_field/diagram` library. Per‑bundle and per‑field
Twig template suggestions (`block`‑style names such as
`mermaid_diagram__node__article__field_diagram`) are generated automatically so a
theme can customise specific diagrams. See the [`agent/`](../agent/start.md) docs
for the exact variables and template structure.

**Bulk import.** The module ships a Feeds target (`mermaid_feeds_target`) that maps
all of the diagram's subfields, so diagrams can be imported in bulk if you use the
Feeds module.
