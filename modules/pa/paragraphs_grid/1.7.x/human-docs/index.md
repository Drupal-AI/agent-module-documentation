# Paragraphs Grid — manual setup guide

**Paragraphs Grid** (`paragraphs_grid`) gives content editors a responsive grid to
arrange their paragraph components in — without writing any layout code. You add a
special "Paragraphs grid" field, and editors get a visual per‑breakpoint column
picker: they choose how many columns each paragraph spans on mobile, tablet, and
desktop, and the module emits the matching grid classes (`col-md-6` and friends) so
the paragraphs line up in a proper responsive grid.

Under the hood it supports several grid frameworks. It ships four presets — Bootstrap
3, Bootstrap 4, Bootstrap 5, and Material Design Components (MDC) — each described by
a `grid_entity` configuration entity that defines the breakpoints, column count,
wrapper (container/row) options, and the CSS‑class patterns for columns, offsets, and
ordering. A global settings form picks which grid system is active and whether the
module loads its own grid CSS or leaves that to your theme.

To use it you add a **Paragraphs grid** (`grid_field_type`) field to a paragraph type
(or its host entity), set the field's edit widget to the **Grid widget** and its
display to a grid formatter. Editors then set columns per breakpoint per paragraph,
and the formatter wraps everything in the right row/column markup. You can also set
per‑breakpoint **offsets** to indent, use **order** classes to reorder visually,
hide columns at certain breakpoints, and make paragraphs full‑ or auto‑width.

Paragraphs Grid requires the contributed **Paragraphs** module and works on Drupal
10 and 11. Note that switching the active grid framework can change or invalidate
stored classes, so the settings form is deliberately gated by a **restricted**
permission for trusted admins only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Paragraphs with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — the global settings form, the grid
   systems, and adding the grid field to a paragraph type.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Paragraphs
Grid** (`/admin/config/content/paragraphs_grid`), gated by the restricted **Use
Paragraphs Grid config form** permission. The grid field itself is configured through
the **Field UI** on the paragraph type (Manage fields / form display / display).

## How to use it

1. Enable the module and, on the settings form, pick the grid framework (grid type)
   you want and whether the module should load its grid CSS.
2. Add a **Paragraphs grid** field to the paragraph type (or the host entity that
   references the paragraphs).
3. Set the field's form widget to **Grid widget** and its display to a grid
   formatter (use *Paragraphs Grid (rendered entity)* on the paragraph reference
   field to render the referenced paragraphs inside the grid markup).
4. Editors then choose columns per breakpoint for each paragraph, building the
   layout visually.

See [Configuration](configuration/index.md) for the field‑by‑field walkthrough.
