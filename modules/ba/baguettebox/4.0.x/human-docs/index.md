# BaguetteBox — manual setup guide

**BaguetteBox** (`baguettebox`) is an image field formatter that opens your
images in a lightbox — click a thumbnail and the full-size image appears in an
overlay you can swipe through. It wraps the
[baguetteBox.js](https://github.com/feimosi/baguetteBox.js) library on the Drupal
side and depends only on core's **Image** module.

Drupal has a long list of lightbox modules — Colorbox, PhotoSwipe, Magnific and
others — and what sets them apart now is size and behaviour rather than features.
BaguetteBox is a deliberately small library with **no dependencies — no jQuery** —
built around swipe gestures and touch. That makes it a sensible default for a
site that wants a gallery without pulling a whole framework onto the page for it.

Two things are worth checking on any lightbox, and they are the things that
separate the good ones:

- **Keyboard and screen-reader behaviour.** A correct implementation traps focus
  inside the dialog while it is open, returns focus to the thumbnail that opened
  it on close, closes on **Escape**, and announces itself as a dialog. A lightbox
  that does none of that is a keyboard trap in the literal accessibility sense —
  test it with the keyboard before you ship it.
- **What gets loaded.** A gallery that fetches full-size images eagerly can be
  several megabytes before anyone opens anything. Confirm the large image is
  fetched on demand.

This version (**4.0.0**) declares an unusually tight core requirement:
**`^11.3 || ^12`** — Drupal 11.3 or later only, and reaching into a major that
does not exist yet. Check your core version before requiring it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no settings page. You apply BaguetteBox per field, in the display
settings:

1. Go to **Structure → Content types → (your type) → Manage display** (or the
   equivalent Manage display screen for whatever entity holds your image field).
2. For your image field, choose the **BaguetteBox** formatter from the format
   dropdown.
3. Adjust any formatter options offered (such as the image style used for the
   thumbnail versus the full-size image), then **Save**.

From then on, that field renders as clickable thumbnails that open in the
BaguetteBox lightbox, with swipe and touch navigation between the images.
