# Canvas Bootstrap — manual setup guide

**Canvas Bootstrap** (`canvas_bootstrap`) brings **Bootstrap 5 components** into the
**Drupal Canvas** visual page editor, so editors can drag‑and‑drop familiar building blocks
— buttons, cards, grids, alerts, carousels, accordions, and more — onto a page without
writing any HTML. All the components are grouped under "Canvas Bootstrap" in the editor and
follow Bootstrap 5 styles, with editable properties (text, links, variants, sizes, outline,
accessibility labels, and so on) exposed for real‑time customisation.

The component set covers layout (rows, columns, wrappers), content (headings, paragraphs,
images, blockquotes, links, badges), and interactive pieces (buttons, alerts, cards with
header/image/body/footer areas, carousels and carousel items, accordion containers and
items). If your active theme already provides a component with the same name, the theme's
version wins, so you can override any piece by shipping your own.

This module works **out of the box** — once installed, the components are automatically
available in Canvas and there is nothing to configure. It does not add content types or admin
pages; everything is managed visually inside the editor. It depends on the **Canvas** module,
and because the components emit Bootstrap markup it assumes a **Bootstrap 5 theme** so they
render as intended (the maintainers suggest the Bootstrap Forge starter theme). On a
non‑Bootstrap theme the components need the framework present to look right.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — it has no settings form and adds no
admin pages. Enabling it is the entire setup; the components then appear in Canvas.

## Where it lives

Canvas Bootstrap adds no admin menu item. Its components appear inside the **Drupal Canvas**
editor, grouped under **Canvas Bootstrap**, ready to drag onto a page or block.

## How to use it

Open a page or block in the Canvas editor, find the **Canvas Bootstrap** component group, and
drag the components you want onto the canvas. Each component exposes editable properties (for
example a button's text, URL, variant, size, and outline) that you set right in the editor.
Make sure your site uses a Bootstrap 5 theme so the components render correctly in both the
Canvas preview and on the front end.
