# Image Compare Viewer — manual setup guide

**Image Compare Viewer** (`icm`) adds a field formatter for image fields that
renders the images on a multi‑value image field as an interactive **before/after
comparison slider** — the kind visitors drag or tap to wipe between two pictures.
It's ideal for "before vs after" renovation photos, retouched‑vs‑original product
shots, treatment‑stage medical imagery, or map/satellite imagery across time.

You configure it entirely from **Manage display** — there is **no separate
settings page** for this module. On an image field's display you pick the *Image
Compare Viewer* formatter, then choose an image style, a slider orientation
(horizontal, vertical, or 45°), and whether each image links to its content or
file. The formatter is responsive, touch‑friendly, and supports a fluid full‑size
mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with its `image` and `jquery_ui` dependencies).

There is **no configuration page** for this module — it has no settings form. All
setup happens on your image field's *Manage display*, described in "How to use
it" below.

## Where it lives in the admin menu

Image Compare Viewer adds no admin page. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage display** — for example
`admin/structure/types/manage/page/display`.

## How to use it

1. Make sure the image field you want to use allows **2 or more values** (set its
   *Allowed number of values* to 2+ or Unlimited), so there are images to
   compare. Add at least two images to a piece of content.
2. Go to that entity's **Manage display** and, for the image field, choose the
   **Image Compare Viewer** formatter.
3. Click the formatter's settings gear and configure:
   - **Image style** — an image style to apply to the compared images for
     consistent sizing, or leave it as *None* to use the original files.
   - **Effect / orientation** — the slider direction: **horizontal**,
     **vertical**, or **45°**.
   - **Link image to** — whether each image links to **nothing**, the **content**
     (its node), or the **file**.
4. Save. On the rendered entity the two (or more) images now appear as a draggable
   comparison slider.

> **Supply‑chain note for production.** This module loads the slider's JavaScript
> and CSS from a third‑party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/icm/...`)
> **without a version or commit pin**, so every render fetches whatever currently
> sits on that GitHub repository's default branch. That's an availability and
> integrity risk — a changed or compromised upstream repo could serve arbitrary
> JavaScript into your pages. For production, download and vendor those assets (or
> pin them to a specific commit) and point the library at local copies.
