# Animated GIF — manual setup guide

**Animated GIF** (`animated_gif`) makes sure animated GIFs keep animating when
Drupal displays them. Normally, when an image field runs through an **image
style** (to resize or crop it), Drupal's GD image toolkit flattens an animated
GIF down to a single frame — so your lively GIF becomes a still picture. This
module detects animated GIFs and serves the *original* file instead of a styled
(flattened) derivative, so the animation survives.

The best part is that it mostly just works. As soon as you enable the module, the
standard **Image** and **Responsive image** formatters automatically bypass image
styles for any file that is an animated GIF, while ordinary static images
continue to use their image styles as usual. The decision is made per file, based
on whether the GIF actually has more than one frame — so a single-frame GIF is
treated like any other image.

It also adds a small courtesy for editors: when someone uploads an animated GIF
to an image field, the widget shows a warning that the file won't be processed by
image styles, so nobody is surprised that it's served full size.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There are no admin pages and nothing to configure. The behavior is automatic once
the module is enabled. The one optional piece — an extra field formatter — is
chosen on a bundle's **Manage display** page (for example
`/admin/structure/types/manage/article/display`).

## How to use it

**The automatic way (recommended).** Just enable the module. Any image or
responsive-image field that happens to render an animated GIF will now serve the
original, still-animated file. There's nothing to switch on per field. Static
images are unaffected and keep using their image styles.

**The optional formatter.** The module also ships a field formatter called
**Animated GIF URL to image**. It works exactly like core's *URL to image*
formatter (it outputs an image URL string rather than an `<img>` tag, and lets
you pick an image style), except that for animated GIFs it returns the original
file's URL instead of the styled derivative. You only need this if you
specifically want the URL-to-image output; for normal `<img>` display the
automatic behavior above already handles it. To use it, go to the field's
**Manage display**, set its **Format** to **Animated GIF URL to image**, and
save.
