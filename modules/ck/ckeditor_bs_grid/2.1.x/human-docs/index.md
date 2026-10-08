# CKEditor Bootstrap Grid — manual setup guide

**CKEditor Bootstrap Grid** (`ckeditor_bs_grid`) adds a toolbar button to
CKEditor 5 that lets editors drop **Bootstrap rows and columns** straight into the
body of a page — building multi‑column layouts inside the rich‑text editor without
touching any HTML. Click the button, pick how many columns you want, choose a
layout for each screen size, and the module inserts the right
`<div class="row"><div class="col-md-6">…` markup for you.

It's aimed at the common case where you want a two‑column split, a three‑up row,
or a 25% / 75% sidebar layout *inside* a body field, without reaching for Layout
Builder or Paragraphs. The insertion dialog is a short three‑step wizard: choose
the number of columns, choose a layout per breakpoint (and optionally wrap it in a
Bootstrap `container` / `container-fluid`, or toggle "no gutters"), and — if you
need it — add extra utility classes to the container, row, or individual columns.

There are two layers of configuration. **Per text format**, you decide which
formats get the button and, for each, which column counts and breakpoints editors
may use, plus whether to load Bootstrap's CSS from a CDN *inside the editor* so the
grid previews correctly. **Site‑wide**, there's a settings page defining the
catalogue of named layouts (like "Equal Width", "25% / 75%", "Full Width") that
each breakpoint and column count offers. Because the output is plain Bootstrap
grid markup, your text format must allow `<div>` with classes — which the plugin
declares for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside CKEditor 5.
2. [Configuration](configuration/index.md) — the site‑wide breakpoint and layout
   catalogue.

## Where it lives in the admin menu

- **Per‑format button:** **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`) — you add the button and set its
  per‑format options while editing a CKEditor 5 format.
- **Site‑wide layout catalogue:** **Configuration → Content authoring → CKEditor
  BS Grid** (`/admin/config/content/ckeditor_bs_grid`), behind the **Administer
  ckeditor_bs_grid** permission.

## How to use it

Getting the button in front of editors is a per‑format job:

1. Go to **Text formats and editors** and edit a format that uses **CKEditor 5**
   (for example *Full HTML*).
2. Drag the **Bootstrap Grid** button from *Available buttons* up into the
   *Active toolbar*.
3. A **Bootstrap Grid** settings tab appears below the toolbar. Set:
   - **Use BS CDN** — whether to load Bootstrap's CSS from a CDN *inside CKEditor
     only* (so the preview looks right). Turn it off to rely on your theme's own
     Bootstrap CSS instead.
   - **CDN URL** — which Bootstrap stylesheet to load when the CDN option is on.
   - **Allowed Columns** — tick which column counts (1–12) editors may choose.
   - **Allowed Breakpoints** — tick which screen sizes editors may tune.
4. Make sure the format doesn't strip the grid markup. On a *Limit allowed HTML
   tags* format the plugin adds `<div class data-*>` for you; on a Full‑HTML‑style
   format nothing extra is needed.
5. **Save**.

Editors then see a **Bootstrap Grid** button in the toolbar. Clicking it opens the
three‑step dialog to insert a grid. Which layouts appear in that dialog comes from
the site‑wide catalogue — see [Configuration](configuration/index.md).
