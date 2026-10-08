# Background Images Formatter — manual setup guide

**Background Images Formatter** (`bg_image_formatter`) adds an image‑field formatter
that renders an uploaded image as a CSS `background-image` on a selector you choose,
instead of emitting an inline `<img>` tag. It's the clean way to let editors supply
hero banners, section backgrounds, and per‑card background images from ordinary content
fields — without hard‑coding those images into your theme.

Rather than output an `<img>`, the formatter builds a CSS rule and injects it into the
page's `<head>` (and attaches it correctly for AJAX responses too). In the formatter's
settings you provide a CSS **selector** to target, an optional **image style**, and a
full set of background CSS properties — color, position, attachment (scroll or fixed),
repeat, size (with `cover`/`contain`), a gradient overlay, a media query, a z‑index,
and an optional `!important`. Selectors support both entity tokens and Views field
tokens, and for multi‑value image fields the selectors and colors are applied one per
value.

It extends Drupal core's image formatter, so it reuses core's image‑style handling, and
it depends only on core's **Image** module. A companion submodule, **Responsive
Background Images Formatter** (`responsive_bg_image_formatter`), swaps the plain image
style for a responsive image style and emits one media‑query rule per breakpoint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and pick the submodule if you need responsive backgrounds.

## Where it lives in the admin menu

There is **no central settings page**. You apply and configure the formatter entirely
on an entity's **Manage display** screen (for example **Structure → Content types →
*(type)* → Manage display**).

## How to use it

1. Add an **image field** to the entity you want to theme (a content type, media type,
   etc.), if it doesn't have one already.
2. Go to that entity's **Manage display** screen and, for the image field, choose the
   **Background Image** formatter.
3. Click the formatter's gear icon to open its settings and fill them in:
   - **Selector** — one CSS selector per line (tokens are supported), naming the
     element(s) that should receive the background. For a full‑page background this
     might be `body`; for a hero it might be a region or block selector.
   - **Image style** — an optional image style (e.g. a cropped/scaled derivative) to
     apply to the background image.
   - **Background CSS properties** — background **color**, horizontal/vertical
     **position**, **attachment** (scroll or fixed for a parallax effect), **repeat**,
     **background‑size** (including `cover`, with an optional IE8 fallback), an optional
     **linear‑gradient** overlay, a **z‑index**, a **media query** to limit the rule to
     a breakpoint, and whether to append **`!important`**.
   - **Image path format** — absolute or relative URLs (relative helps avoid
     mixed‑content warnings on HTTPS sites).
4. Save the display. For a **multi‑value** image field, list several selectors (and
   colors) — they're applied round‑robin, one per value, so one field can theme several
   elements.

You can also put entity tokens or Views field tokens (`{{ … }}`) in the selector to
scope the styles per node or per row.
