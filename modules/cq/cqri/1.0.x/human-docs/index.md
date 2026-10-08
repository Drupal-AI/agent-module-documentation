# CQRI (Container Query Responsive Image) — manual setup guide

**CQRI** (`cqri`) extends Drupal core's **Responsive Image** so an image can choose
its source based on the size of the **container** it sits in, rather than the size of
the browser viewport. Core's responsive images answer "how wide is the window?"; CQRI
answers "how wide is the block this image is in?" — which is what you actually want in
component-based, Layout Builder-style page building, where a section's structure (not
the window) determines how much room an image gets.

It works by providing two things that mirror the core workflow:

- a **breakpoint group** called *Container Queries Responsive Images*, based on core's
  Responsive Image, and
- a **Container Queries Responsive Images** field formatter for image fields, which
  uses responsive image styles built on that breakpoint group.

You use these exactly like the classic responsive image style, with one difference:
the breakpoints describe the **container's** size, not the window's. Under the hood the
module ships a JavaScript script that makes the HTML `<picture>` element react to a
"container" mode instead of the usual `media` (viewport) mode — the maintainer notes
both the module and that script are in active development, so test carefully on your
target site. Images still follow core's media/image access; the module has no
access-control role. It depends only on core **Responsive Image**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Responsive Image.

There is **no dedicated settings page** for CQRI. You work with the responsive image
tools core already provides, described below.

## How to use it

1. **Create a responsive image style** at **Configuration → Media → Responsive image
   styles** (`/admin/config/media/responsive-image-style`). Choose the **Container
   Queries Responsive Images** breakpoint group that CQRI provides, and map image
   styles to each breakpoint — the same way you would for a normal responsive image
   style, but the breakpoints now describe the container size rather than the viewport.
2. **Apply the formatter** on your image field. Go to **Structure → (your entity type)
   → Manage display**, and in the Format column choose **Container queries responsive
   image**. Then pick the responsive image style you just created.
3. **Save** and view the content. The image now picks its source based on the size of
   its container — resize a Layout Builder section or block and the image responds to
   the block, not the window.
