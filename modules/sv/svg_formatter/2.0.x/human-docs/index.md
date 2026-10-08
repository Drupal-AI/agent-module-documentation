# SVG Formatter — manual setup guide

**SVG Formatter** (`svg_formatter`) lets you show SVG (vector) images on your
Drupal site. Core's Image field refuses SVG files because an SVG has no fixed
pixel dimensions, so this module takes a different route: you upload your SVGs
into an ordinary **File** field and then pick the module's **SVG Formatter**
display format to render them properly — either as a normal `<img>` tag or as
sanitized inline `<svg>` markup embedded directly in the page.

Inline output is the interesting part. Because the SVG's own markup ends up in
the page, you can recolour it with CSS, animate its shapes with JavaScript, or
hover-highlight individual paths — none of which is possible with a flat `<img>`.
Before inlining, the module can run each file through a bundled sanitizer
(`enshrined/svg-sanitize`) that strips scripts and other unsafe content, which
matters if you let non-trusted users upload SVGs. It can also add an accessible
`<title>` and wire up `aria-labelledby` automatically.

There is **no admin settings page**. Everything the module does is controlled by
the formatter's own settings on a field's *Manage display* tab — width and
height, inline vs. `<img>`, sanitizing, and the `alt`/`title` text (which can
default to a tidied-up version of the file name or be driven by tokens such as
`[node:title]`). The module works with Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to configure globally. You use SVG Formatter per field:

1. Add a core **File** field to your content type (or media type, taxonomy term,
   etc.) and set its **Allowed file extensions** to include `svg`.
2. Go to the bundle's **Manage display** tab, find your file field, and change its
   **Format** to **SVG Formatter**.
3. Click the gear/cog icon to open the format's settings and choose how to render:
   - **Output SVG inline** — off gives you an `<img>` tag; on embeds the SVG
     markup directly (needed for CSS recolouring or JS animation).
   - **Sanitize inline SVG** — recommended on; strips unsafe content. Only applies
     to inline output, and the checkbox is disabled if the sanitizer library is
     missing.
   - **Apply dimensions** with **width** and **height** (both default to 100) —
     untick to let CSS size the image instead.
   - **alt** and **title** toggles, each with an optional token string. Leave the
     token empty and the module derives the text from the file name (strips
     `.svg`, turns `-`/`_` into spaces, capitalises the first letter).
4. Click **Update**, then **Save**.

Only files whose type is actually `image/svg+xml` are rendered — so if you mix
SVGs and other files in one field, the non-SVG items are simply skipped.

An **Image** field can use the formatter too, but only when the separate
`svg_image` contrib module is also enabled; otherwise the format is offered only
on File fields.

## Where it lives in the admin menu

Nowhere of its own — SVG Formatter adds no admin pages, permissions, or menu
items. You reach it entirely through the **Manage display** tab of whichever
entity type holds your File field (for example
`/admin/structure/types/manage/article/display` for the Article content type).

## Good to know

- Inline mode reads the file from disk on every render and embeds the whole SVG
  in the page HTML — fine for icons and logos, less ideal for very large files.
- On an inline `<svg>` the `alt` attribute is meaningless, so accessibility relies
  on the **title** path; leave the title enabled to give inline SVGs an accessible
  name.
- For full control over the wrapper markup you can override the
  `svg-formatter.html.twig` template in your theme.
