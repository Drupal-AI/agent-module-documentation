# CKEditor Tippy Tooltip — manual setup guide

**CKEditor Tippy Tooltip** (`ckeditor_tippy`) adds a toolbar button to CKEditor 5
that turns selected text (or an image) into a hover tooltip. Editors click the
button, type the visible text and the tooltip text into a small dialog, and the
module wraps the result in a single semantic `<tippy>` element. On the front end,
that element is rendered as an accessible Tippy.js / Popper tooltip that appears
when a visitor hovers.

It is ideal for inline glossary definitions, footnotes, or contextual help that
you want available without sending the reader to another page. The tooltip and
Popper libraries are only loaded on pages that actually contain a tooltip, so
pages without one carry no extra weight. Popper can be served from a local
`libraries/popperjs` copy if you have one, otherwise from a CDN.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module needs a little setup on each text format where you want tooltips:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5**.
2. Drag the **Tippy Tooltip** button from the available buttons into the active
   toolbar.
3. If the format uses **Limit allowed HTML tags**, make sure it permits the tippy
   markup: `<span>`, `<tippy>`,
   `<tippy data-tippy-content class="tippy-tooltip-text">`, and
   `<img data-tippy-content>`.
4. Enable the **"Insert Popper when tippy is present"** filter on that format so
   the Tippy.js/Popper libraries are attached to any rendered content that
   contains a tooltip.

Now, when editing content in that format, an author selects some text (or an
image), clicks the Tippy Tooltip button, and fills in the **body text** (what
readers see) and the **tooltip text** (what appears on hover). Each field accepts
up to 2048 characters.

### Global tooltip behaviour

There is also a small settings form at
**Configuration → Content authoring → CKEditor Tippy**
(`/admin/config/content/ckeditor-tippy`, permission **Administer ckeditor
tippy**). It sets defaults that the front-end JavaScript reads for every tooltip:

- **Follow cursor** — whether the tooltip tracks the mouse (off, both axes,
  horizontal only, or vertical only).
- **Prevent overflow** — keep the tooltip inside the viewport edge.
- **Placement** — the preferred side: top, right, bottom, or left.
- **Fallback placement** — prevent flipping to the opposite side when the
  preferred side does not fit.
- **Interactive** — allow the tooltip content itself to be hovered and clicked
  without it disappearing (useful when the tooltip contains a link).

These options are global, so all tooltips on the site share a consistent style.
