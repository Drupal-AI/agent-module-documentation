# CKEditor GLightbox Inline — manual setup guide

**CKEditor GLightbox Inline** (`ckeditor_glightbox_inline`) makes images embedded
in your rich‑text content open in a **GLightbox** lightbox — a clean overlay that
pops the image up over the page — instead of just sitting inline. Normally, wiring
images up for GLightbox means adding specific HTML wrappers and CSS classes by
hand. This module removes that chore: it provides a **text filter** that
automatically prepares inline images for GLightbox, so editors just insert images
into CKEditor as usual and the module handles the rest on output.

Despite the name, this is really an output filter rather than a CKEditor button —
editors do nothing special in the editor. It depends on the **GLightbox** module
(which wraps the GLightbox JavaScript library), and it has no settings page of its
own. The only setup step is turning the filter on for the text format(s) whose
images you want to open in a lightbox.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its GLightbox dependency.

There is **no configuration page** for this module. You enable its text filter per
text format, described under "How to use it" below.

## How to use it

The behavior is controlled by a text filter that you enable per format:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the format whose inline images you want to open in
   a lightbox.
3. Under **Enabled filters**, turn on the GLightbox inline‑images filter.
4. If the format lets you order filters, place it sensibly relative to other image
   filters, then click **Save configuration**.

After that, insert images into your content in that format as you normally would —
on the published page they will open in a GLightbox overlay when clicked.
