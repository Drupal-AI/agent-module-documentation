# Inline Styled Images — manual setup guide

**Inline Styled Images** (`inline_responsive_images`) lets editors choose a Drupal
**image style** or **responsive image style** for images inserted through the
CKEditor 5 image dialog — instead of typing raw pixel width and height. That means
inline body images get consistent, structured sizing from your site's named styles,
serve appropriately sized derivatives for performance, and can even use art-directed
responsive images (a `<picture>` element with different crops per breakpoint) right
from within rich text.

It ships two text-format filters — **Display image styles** and **Display
responsive images** — each paired with a CKEditor 5 plugin. You enable one of the
filters on a text format and tick the styles you want editors to be able to pick.
In the editor, a style dropdown then appears on the image balloon toolbar; the
editor's choice is stored as a small `data-image-style` (or
`data-responsive-image-style`) attribute on the `<img>` tag. At render time the
filter reads that attribute, loads the image, and swaps the tag for a properly
themed image or `<picture>` element.

Because the stored markup keeps only the data-attribute — not fixed dimensions — the
transform is **reversible**: switching an image to a different style later is just a
one-attribute change, and editors are never locked into hard-coded sizes. There is
**no admin settings page**; all configuration lives on the text format. The module
requires core's Editor, Image and CKEditor 5 modules, plus Responsive Image for the
responsive-style filter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has no settings page of its own — you configure it on a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** a format that uses the **CKEditor 5** editor and has the image
   button in its toolbar.
3. Under **Enabled filters**, turn on **either** **Display image styles** *or*
   **Display responsive images** — not both on the same format (see the note below).
4. In that filter's settings, tick the image styles (or responsive image styles) you
   want to offer editors. Only the ones you tick appear in the editor dropdown.
5. **Ordering caveat:** if the *Restrict images to this site* or *Track images
   uploaded via a Text Editor* filters are enabled on this format, place this
   module's filter **after** them in the processing order (or leave those off),
   otherwise the transform can be undone.
6. Save.

Editors now get a **Drupal image style** (or **Drupal responsive image style**)
dropdown on the image balloon toolbar when they insert or select an image. Pick a
style and Drupal generates the correctly sized `<img>` — or a responsive
`<picture>` — at render time.

**Do not enable both filters on one format.** A responsive `<picture>` mapping
should not be wrapped again in a plain image style, so the module deliberately hides
the image-style selector when the responsive-image filter is also active. Choose one
filter per format. Different formats can, of course, expose different sets of allowed
styles.
