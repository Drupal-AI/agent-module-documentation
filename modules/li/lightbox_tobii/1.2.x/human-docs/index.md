# Tobii Lightbox Image Formatter — manual setup guide

**Tobii Lightbox Image Formatter** (`lightbox_tobii`) adds a field formatter
that opens your image fields in a clean, accessible **Tobii** lightbox when a
visitor clicks a thumbnail. Instead of navigating away to a full‑size image, the
picture pops up in a modal overlay that the visitor can dismiss to return to the
page — the familiar "click the photo to zoom" behavior, powered by the
lightweight [Tobii](https://github.com/midzer/tobii) JavaScript library.

It is purely a **display** feature: images still render according to your normal
file and field access, and the module adds no access control of its own. You turn
it on for a specific image field by choosing the Tobii formatter on that field's
*Manage display*. It depends on the [Lightbox](https://www.drupal.org/project/lightbox)
module, and it needs the Tobii JavaScript library present in your site's
`libraries/` directory (Composer installs it for you — see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Tobii
   library with Composer, then enable it.

This module has **no central settings page**. Everything is configured on the
image field itself, described in "How to use it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage display**
   (or the Manage display of any bundle that has an image field).
2. Find your **image field** and, in the **Format** column, choose the **Tobii**
   lightbox formatter.
3. Use the formatter's gear/settings to pick the image styles for the thumbnail
   and the full‑size image if those options are offered.
4. Save the display. Now, on the rendered page, clicking the image opens it in
   the Tobii lightbox.
