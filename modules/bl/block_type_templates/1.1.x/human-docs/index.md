# Block Type Templates — manual setup guide

**Block Type Templates** (`block_type_templates`) lets you theme content blocks
differently depending on their **block type** and **view mode** — something Drupal
core doesn't support out of the box. Core gives you block templates keyed by plugin
and instance, but not by content block *type*, so a "Testimonial" block and a "Call
to action" block are hard to style separately from the theme layer. This tiny module
fills that gap.

It does its work through two theming hooks and needs **no configuration at all**. The
first adds new Twig template suggestions so that, for any content block, you can drop
a file named after its block type into your theme and every block of that type picks
it up automatically. The second adds handy CSS classes to the block wrapper —
`block-type--<type>` — giving you a stable per‑type hook for CSS or JavaScript even
when you don't add a template.

It works with standard block placement, Panels, and Layout Builder inline blocks, and
pairs nicely with the Components/SDC approach for reusable sub‑templates. There are no
settings, permissions, services, or plugins — it's purely a front‑end developer's
helper.

This guide is written for a **human** working in the theme layer. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — it has no admin UI. You work with it entirely in your theme's
`templates/` directory and your CSS.

## How to use it

### Per‑type templates

Once enabled, each content block gains template suggestions named after its block
type (and, optionally, its view mode). For a block type with the machine name
`testimonial`, create either of these files in your theme's `templates/` folder:

```
block--block-content-testimonial.html.twig
block--block-content-testimonial--teaser.html.twig   (for the "teaser" view mode)
```

Underscores in the machine name become hyphens in the filename, following Drupal's
usual rule. A good starting point is to copy core's `block.html.twig` — it keeps the
standard block markup and fields, and you adjust from there.

After adding the file, clear caches (`drush cr`) so the theme registry picks it up. If
you enable Twig debugging, the rendered HTML's `FILE NAME SUGGESTIONS` comment
confirms the new suggestion is being offered.

### Per‑type CSS classes

Without writing any template, you also get extra classes on the block wrapper you can
target in CSS or JS:

- **Content blocks** get `block-content` plus `block-type--<type>`.
- **Layout Builder inline blocks** get `inline-block` plus `block-type--<type>`.

The type name is made CSS‑safe (hyphenated), so a `call_to_action` type produces
`block-type--call-to-action`.

These features only affect content blocks and inline blocks; other block kinds are
untouched.
