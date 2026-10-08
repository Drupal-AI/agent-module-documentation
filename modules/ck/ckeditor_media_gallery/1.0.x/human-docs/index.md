# CKEditor Media Gallery — manual setup guide

**CKEditor Media Gallery** (`ckeditor_media_gallery`) adds an image‑gallery widget
to **CKEditor 5**. An editor clicks a toolbar button, picks any number of images
from the core **Media Library** in multi‑select mode (selection order is
preserved), and drops a gallery anywhere in the body text — no extra content types
or entities required.

What makes it pleasant to use is that the widget in the editor renders with the
same template and CSS as the front end, so what an editor sees is what the page
shows. Galleries support four display types, switchable per gallery from the
widget toolbar — a large image with a thumbnail strip, a masonry grid, a carousel,
and a uniform grid — plus an optional per‑gallery heading, drag‑and‑drop
reordering, and an "add images" button. A fullscreen lightbox (via the MIT‑licensed
GLightbox library) shows per‑image captions and copyright drawn from configurable
media fields, and remote (YouTube/Vimeo) and local videos are supported with a
play badge inline. Images can render through an image style or a responsive image
style, and the whole thing is keyboard‑accessible with ARIA labels and
reduced‑motion support.

Storage stays clean: the gallery is saved as a single `drupal-gallery` element in
the text and rendered by a text filter, so content stays portable and
theme‑independent — there are no extra entities to manage. Use it for news
articles, blog posts, or any long‑form content where editors need photo series at
arbitrary points in the text without switching to a Paragraphs‑based body.

Two things to be aware of before you rely on it. First, by default the **GLightbox
library is loaded from the jsDelivr CDN** — that means visitors' browsers fetch a
script from an external host. If your site's policy is to serve all assets
locally (for privacy, offline, or content‑security‑policy reasons), override the
`glightbox` library definition in a theme or module to point at a local copy.
Second, this is an early release (1.0.0‑alpha1) and is **not yet covered by the
Drupal security advisory policy**, so weigh that for production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core Media dependencies.
2. [Configuration](configuration/index.md) — add the button to a text format,
   enable the gallery filter, and tune media types, display, image styles,
   lightbox, and caption/copyright fields.

## Where it lives in the admin menu

There is no standalone settings page. Everything is configured on the **text
format** at **Administration → Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`): drag the Image gallery button
into the CKEditor 5 toolbar and enable the "Embed image galleries" filter. Once
that is done, galleries are created and edited entirely inside CKEditor. The full
walkthrough is in [Configuration](configuration/index.md).
