# GLightbox — manual setup guide

**GLightbox** (`glightbox`) integrates the pure‑JavaScript **GLightbox** library into
Drupal, adding image field formatters that open images — and videos, via the Plyr player —
in a responsive lightbox popup, with optional galleries, captions, zoom, and transition
effects. Click a thumbnail and the full image opens in a smooth modal instead of navigating
away from the page. It's a dependency‑light (no jQuery) choice for product galleries,
portfolios, and image‑heavy content.

The module ships two image field formatters — **GLightbox** and **GLightbox Responsive**
(the latter uses responsive image styles) — that render a thumbnail linking to the full
image opened in the lightbox. A global settings form controls the site‑wide defaults
(transition effects, dimensions, zoom/drag, caption behaviour, the Plyr video player
options), while each formatter's own settings control the image styles, gallery grouping,
and caption sources for that specific field. Items that share a gallery id page through one
lightbox together. You can even suppress the lightbox on a given request by appending
`?glightbox=no` to a URL.

GLightbox requires three external JavaScript libraries — GLightbox itself, DOM Purify (for
sanitising captions), and Plyr (for video) — which are declared as Composer packages and
should sit under `/libraries`; the module prefers those local copies over any CDN. It
depends on core's Image module. A submodule, **GLightbox Inline**, extends the lightbox to
open arbitrary on‑page elements, whole pages, videos, or images via a link class.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its JS libraries with
   Composer, enable it, and add the GLightbox Inline submodule.

## Where it lives in the admin menu

The global settings form is at **Configuration → Media → GLightbox**
(`/admin/config/media/glightbox`), and requires the *Administer site configuration*
permission. Per‑field settings live on each content type's **Manage display** page.

## How to use it

### 1. Apply a formatter to an image field

1. Go to the bundle's **Manage display** (e.g.
   `/admin/structure/types/manage/article/display`).
2. Set your image field's format to **GLightbox** (or **GLightbox Responsive** to use a
   responsive image style for the opened image).
3. Click the cog to configure the field's own settings:
   - the **thumbnail image style** (the small image shown on the page),
   - the **lightbox image style** (the larger image opened in the popup),
   - **gallery grouping** — whether all items in the field form one gallery, and an
     optional custom gallery id token,
   - the **caption** and longer **description** sources.
4. Click **Update**, then **Save**. Items sharing a gallery id navigate together inside one
   lightbox.

### 2. Adjust the global settings (optional)

At **Configuration → Media → GLightbox** you set the site‑wide defaults, grouped into three
sections:

- **Custom** — the lightbox look and feel: open/close/slide **effects** (zoom, fade, slide,
  none), **width** and **height** (default `98%`), **video width**, **loop**, **zoomable**,
  **draggable**, **preload**, close‑on‑outside‑click, the **description position**
  (bottom/top/left/right), and a **"See more"** caption toggle with a character threshold
  before long captions are truncated.
- **Advanced** — a **unique gallery token** (give each entity its own gallery id so
  galleries don't merge across nodes) and whether to load **minified** or **source** assets.
- **Plyr** — the video player: enable Plyr and choose which **controls** and **settings**
  appear (play, progress, current time, mute, volume, captions, quality, fullscreen, and
  more).

Tip: booleans set with a bare `true`/`false` via `drush cset` can be miscast — prefer the
settings form, or use `1`/`0`.

### 3. Disable the lightbox on a specific page

Append `?glightbox=no` to a URL to render that page's images without wiring up the lightbox
— handy for print or debugging.
