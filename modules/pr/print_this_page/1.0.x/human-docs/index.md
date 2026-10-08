# Print This Page — manual setup guide

**Print This Page** (`print_this_page`) adds a customisable **"Print this page"**
button that opens the browser's own print dialog for the current page — while hiding
the page elements you don't want on paper, such as the header, footer, navigation,
and sidebars. Everything happens **client‑side**: it calls `window.print()` and
applies a print stylesheet. There's no server route, no PDF generation, and no
permissions.

You can add the button in **two places**:

- as a **block** (`print_this_page_block`), placed in any region via **Block
  layout**; or
- as a **field formatter** (`print_this_page`), added to a field on a content type's
  display for per‑content‑type control.

Both offer the same three settings — the button's **link text**, whether to **show
the printer icon**, and a **comma‑separated list of CSS selectors to exclude** from
the printed output (default `header, footer, aside, nav, form, iframe, .menu`). The
button is accessible (proper ARIA attributes and hover/focus/active states), hides
itself when JavaScript is disabled to avoid confusion, and can fire Google Analytics
`dataLayer` events.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central module settings page** — you configure the button where you
place it (in the block form, or in the field formatter settings). Those settings are
described in "How to use it" below.

## How to use it

### Option A — place the block

1. Go to **Structure → Block layout**, choose a region, and place the **Print This
   Page** block (it's in the *Custom* category).
2. In the block form, set:
   - **Link Text** — the button's label (default *"Print this page"*).
   - **Show print icon** — toggle the printer icon next to the text.
   - **Elements to exclude from printing** — comma‑separated CSS selectors to hide
     when printing.
3. Save. The button appears in that region on the pages the block is configured for.

### Option B — add the field formatter

1. Go to a content type's **Manage display** (the formatter applies to
   boolean / string / text / entity‑reference fields).
2. Set the field's format to **Print This Page**. The same three settings — link
   text, show icon, exclude list — appear in the formatter's settings.
3. Save. The print button renders with that field on the content type.

### Tuning the exclude list

The exclude list is where you strip site chrome from the printout. Add any CSS
selectors — IDs, classes, or element names — you want hidden when printing, for
example:

- `header, footer, aside, nav` — hide structural elements;
- `.menu, .breadcrumb` — hide navigation;
- `form, iframe` — hide interactive elements;
- `#sidebar, .comments` — hide specific sections.

The button remains available to anonymous visitors, and the same exclude list can be
reused across the block and formatter placements.
