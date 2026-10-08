# CKEditor Accordion — manual setup guide

**CKEditor Accordion** (`ckeditor_accordion`) adds an **Accordion** button to Drupal's
CKEditor 5 rich‑text editor. Editors use it to insert collapsible accordion sections
right inside body content — a title row that, when clicked on the published page,
expands to reveal its content. It's ideal for FAQs, product specifications, terms and
conditions, documentation, and any "click to reveal" progressive‑disclosure layout.

When you insert an accordion, the editor shows a small balloon toolbar for adding a row
above or below, or removing a row. Under the hood the content is stored as a plain
description list — `<dl class="ckeditor-accordion">` with paired `<dt>` (title) and
`<dd>` (content) elements — so it degrades gracefully and stays portable. On the front
end the module attaches a small script that finds every accordion, makes the titles
clickable, opens the first row by default, and handles deep‑linking via URL hashes.

The module registers a CKEditor 5 plugin and requires core's **CKEditor 5** module.
It also ships a small upgrade path that maps the legacy CKEditor 4 "Accordion" button
onto the CKEditor 5 one, so old text formats upgrade cleanly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There are two admin touch‑points:

- **Text formats and editors** (`/admin/config/content/formats`) — where you add the
  Accordion button to a text format's CKEditor 5 toolbar (this is the required step).
- **CKEditor Accordion settings** (`/admin/config/content/ckeditor-accordion`) — a
  small optional form for global front‑end display behavior, gated by the **Administer
  ckeditor accordion** permission.

## How to use it

**1. Add the button to a text format.** Go to **Configuration → Content authoring →
Text formats and editors**, edit a format that uses CKEditor 5 (for example *Basic
HTML*), and drag the **Accordion** button from the *Available buttons* tray onto the
*Active toolbar*.

**2. Allow the accordion tags.** That format's *Allowed HTML tags* must permit the
description‑list markup the accordion uses: `<dl class>`, `<dt>` and `<dd>`. If the
format uses a restrictive filter, add those tags so accordions aren't stripped on save.

**3. Insert an accordion.** In any content using that format, click the **Accordion**
toolbar button. Type a title in each `<dt>` row and its content in the `<dd>` below;
use the balloon toolbar to add rows above/below or remove a row.

**4. (Optional) Tune the display.** The settings form at
`/admin/config/content/ckeditor-accordion` controls global front‑end behavior passed
to the JavaScript, including:

- **Collapse all** — start with every row closed (rather than the first open).
- **Keep rows open** — let multiple rows stay open at once instead of closing others.
- **Animate toggle** — enable or disable the open/close animation.
- **Open tabs with hash** — allow deep‑linking to a specific row via a `#` URL anchor.
- **Allow HTML in titles** — permit markup (such as icons) inside the row titles.

The styling is intentionally minimal, so themers can override it with their own CSS.
