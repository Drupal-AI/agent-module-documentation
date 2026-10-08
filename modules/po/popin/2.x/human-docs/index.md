# Popin — manual setup guide

**Popin** (`popin`) lets you display a popin — a modal / lightbox overlay — on your
website. It is the kind of element you reach for when you want an announcement, a
promotion, or a prompt to appear over the page, and it is configured entirely
through the admin UI.

A popin is built from a few optional pieces: a **title**, a **subtitle**, an
**image**, a **WYSIWYG content area**, and a **link** — all of them optional, so you
include only what you need. The field order is set by a template
(`block-popin.html.twig`) that you can override in your theme if you want a
different layout. You control when the popin appears: by date range, or globally,
and you can further limit where it shows using standard block visibility settings.

By design the popin is shown **once per user session**. Note that saving the popin
configuration resets that "already seen" state, so after you change the content
every visitor will see the updated popin again.

The content is admin-configured, so there is no unusual security surface. Two things
to keep in mind are matters of good practice rather than security: a popin that
appears before a visitor has consented to tracking should not itself set tracking
cookies, and intrusive popins hurt the user experience — so use it deliberately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no central settings form**. You place the popin as a block and
edit its content and visibility from the content admin area — see "How to use it"
below.

## Where it lives in the admin menu

You configure the popin's content and visibility at **`/admin/content/popin`**, and
you place the **Popin block** into a region through **Structure → Block layout**.

## How to use it

1. After enabling the module, go to **Structure → Block layout** and add the
   **Popin block** to a region (the footer works well, since the popin is displayed
   as an overlay regardless of the region).
2. Use the block's **visibility settings** if you want the popin only on certain
   pages — for example the front page.
3. Go to **`/admin/content/popin`** to set the popin's content: fill in whichever of
   the title, subtitle, image, WYSIWYG area and link you want to show.
4. Set the popin's **visibility by date** (a date range) or leave it global.
5. Save. The popin appears once per session for visitors. Remember that changing and
   re-saving the configuration resets the once-per-session tracking, so returning
   visitors will see the updated popin again.
