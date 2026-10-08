# PhotoSwipe Inline — manual setup guide

**PhotoSwipe Inline** (`photoswipe_inline`) extends the
[PhotoSwipe](https://www.drupal.org/project/photoswipe) module so that images placed
*inline* — inside body text, embedded through CKEditor, or built into a custom render
array — open in a PhotoSwipe lightbox. The PhotoSwipe module on its own wires the
lightbox to image *fields* as a formatter, which covers a node's gallery field but
not images scattered through editorial content. This module fills that gap.

It works by adding a **text filter**. Normally, to make an inline image open in
PhotoSwipe you would have to hand‑add specific HTML tags and CSS classes around each
image. This module's filter does that automatically: you insert images however you
like (for example straight into CKEditor), enable the filter on that text format,
and the images become part of a PhotoSwipe gallery — with pinch‑zoom, swipe
navigation and on‑demand loading of the full‑resolution image. It builds on and
requires the PhotoSwipe module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its PhotoSwipe dependency).

There is **no dedicated configuration page** for this module — you switch it on by
enabling its text filter on a text format, described in "How to use it" below.

## How to use it

1. Install and enable this module and the PhotoSwipe module (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit the text format your authors use for body content (for example *Full HTML*),
   and in the **Enabled filters** list turn on the PhotoSwipe Inline filter.
4. Check the filter order and save.
5. Insert images into content using that format however you normally do — including
   through CKEditor. They will now open in the PhotoSwipe lightbox on the rendered
   page.
