# Colorbox Inline — manual setup guide

**Colorbox Inline** (`colorbox_inline`) extends the Drupal **Colorbox** module so
a link can open content that is *already on the same page* inside a Colorbox
lightbox. You mark up a trigger link with an HTML `data-` attribute that points
at another element on the page, and clicking it pops that element open in a modal
— no PHP, no configuration, and no AJAX round‑trip.

This is the right tool when the modal content is small and already rendered on
the page: a hidden login form, a terms‑and‑conditions block, a newsletter signup
tucked away in the footer, extra product details in an off‑screen `<div>`. If the
source element is hidden with `display:none`, the module temporarily reveals it
while the modal is open and re‑hides it afterward, so you can keep the markup out
of the normal page flow. Per‑link `data-` attributes let you override the modal
width, height, CSS class, and grouping. (For content that must be *fetched* over
AJAX rather than already present, use the separate
[Colorbox Load](https://www.drupal.org/project/colorbox_load) module instead.)

The module works the moment you enable it — there is **no admin UI, no settings
form, no permissions, and no Drush commands**. It attaches the parent Colorbox
library plus its own small JavaScript behavior on every page, then wires up any
element carrying a `data-colorbox-inline` attribute. It depends on the
**Colorbox** module (`colorbox`), which in turn requires the jQuery Colorbox
JavaScript library to be installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the runtime
behavior and library attachment details — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Colorbox
   dependency) with Composer, and enable it.

## Where it lives in the admin menu

Nowhere — Colorbox Inline has no configuration page. Global lightbox styling and
transitions come from the parent **Colorbox** module's settings form at
**Configuration → Media → Colorbox** (`/admin/config/media/colorbox`); Colorbox
Inline simply reuses those and lets you override them per link.

## How to use it

Once the module is enabled, add a `data-colorbox-inline` attribute to any link (or
element) whose value is a **CSS selector** for another element on the same page:

```html
<a data-colorbox-inline=".user-login" href="#">Log in</a>

<!-- The source content, anywhere on the page. It may be hidden. -->
<div class="user-login" style="display:none;">
  … form markup …
</div>
```

Clicking "Log in" opens the first element matching `.user-login` in a Colorbox
modal.

Optional attributes fine‑tune a single trigger:

| Attribute | What it does |
|-----------|--------------|
| `data-width` | Sets the modal width. |
| `data-height` | Sets the modal height. |
| `data-class` | Adds an extra CSS class to the Colorbox wrapper for custom styling. |
| `data-rel` | Groups triggers — give several the same value to enable prev/next navigation between them. |

A few practical notes:

- Keep the source element hidden (`display:none`) if you don't want it shown in
  the normal page flow; the module reveals it only while the modal is open.
- To author these links inside a WYSIWYG body field, use a text format (such as
  **Full HTML**) that does not strip `data-*` attributes.
- A `data-colorbox-inline` value that contains a `<` character is ignored — the
  attribute expects a selector, not raw HTML.
- With JavaScript off, the source content simply remains on the page, so it
  degrades gracefully.
