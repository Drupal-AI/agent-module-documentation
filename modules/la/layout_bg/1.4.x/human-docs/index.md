# Layout BG — manual setup guide

**Layout BG** (`layout_bg`) makes background images easy in Layout Builder. It adds
section layouts that include a dedicated **background region**: you drop any block —
usually an image or media field block — into that region, and Layout BG renders it as
a real `<img>` (or `<video>`) sitting behind your content, positioned with CSS
`object-fit` so it behaves like a background image. Because it's a real image element
rather than a CSS `background-image`, it stays fully compatible with image styles,
responsive images, lazy loading (core or Blazy), and accessibility.

Two layouts ship: a **one‑column** layout with a background region (great for hero
banners) and a **two‑column** layout where a single background sits behind both
columns. Each section you place gets a small set of options in Layout Builder's
"Configure section" tray: a fallback background color, an optional semi‑transparent
colored **overlay** (with adjustable opacity) to keep text readable over busy images,
an inline **text color** for content over dark images, a link‑underline toggle, an
option to **center content** over the image, and a choice between *static* positioning
(the image takes up layout space) and *absolute* positioning (out of the flow).

There's no global settings page and no permissions of its own — it relies entirely on
Layout Builder's own access control, so anyone who can edit layouts can use it. The
module also ships several example sub‑modules (not enabled by default) demonstrating
patterns like article teasers, brick grids, and paragraph backgrounds.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. The layouts appear inside **Layout Builder** whenever you
add a section to an entity whose display uses Layout Builder (under *Structure →
Content types → … → Manage display*, or when editing a layout).

## How to use it

1. Enable Layout Builder for the entity view display you want (on the entity type's
   **Manage display** tab).
2. Edit the layout and **Add section**. Choose **One‑Column Layout with Background
   Region** (under *Columns: 1*) or **Two‑Column Layout with Background Region**
   (under *Columns: 2*).
3. Add a block to the **Background** region — typically a field block for an image or
   media field, using any formatter that outputs an `<img>` (image, responsive image,
   Blazy, media thumbnail). Only the first non‑empty block in the region is rendered,
   and its label is hidden automatically.
4. Add your content to the **content** region (or **first** / **second** on the
   two‑column layout).
5. Open the section's **Configure section** tray to set the visual options:
   - **Use Static Image** — on keeps the image in the layout flow; off positions it
     absolutely, out of the flow.
   - **Center Content** — center the content over the image (available with static
     positioning).
   - **Background Color** — a fallback color shown before or if the image fails to
     load (default grey).
   - **Set Text Color** / **Text Color** / **Underline Links** — apply an inline text
     color to the content (default white) and toggle link underlines — handy over dark
     images.
   - **Add Overlay** / **Overlay Color** / **Overlay Opacity** — layer a colored,
     semi‑transparent overlay over the background to improve contrast; tune its color
     and opacity.
   The two‑column layout also has the usual **column widths** setting.
6. Save the layout.

### Theming

The layouts render through a shared `layout--layout-bg.html.twig` template. Copy it
into your theme and clear caches to customize the wrapper markup. Developers can also
add a background region to their own custom layout plugin by mixing in the module's
`LayoutBgTrait`.
