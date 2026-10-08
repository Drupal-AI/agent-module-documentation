# CKEditor5 Media Resize — manual setup guide

**CKEditor5 Media Resize** (`ckeditor_media_resize`) lets editors **drag-resize embedded
media images** right inside CKEditor 5. Grab the corner of a `<drupal-media>` image embed,
drag it to the width you want, and the module records that width and renders it — optionally
swapping in a matching, correctly-sized image derivative so the browser downloads a smaller
file instead of a full-size original scaled down with CSS.

Under the hood it adds one CKEditor 5 plugin (which attaches resize handles to the existing
media widget) and one text filter, **"Resize media images"**, which converts the stored
width into the final markup at render time. It ships four ready-made image styles
(200, 500, 800 and 1200 px wide) plus matching media view modes, and by default it maps a
requested width to the smallest of those styles that is big enough — so a 300 px embed is
served from the 500 px derivative. You can turn that image-style swapping off and keep just
the CSS width if you prefer.

There is **no module settings page**. You switch it on per text format, by enabling the
filter, adding the media button to the toolbar and ordering the filter correctly. Its one
real option — whether to apply image styles — lives on the CKEditor plugin's settings within
each text format. The module needs Drupal core `^10.3 || ^11` and core's **CKEditor 5** and
**Media Library** modules; it has no permissions or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — enable media resizing on a text format and set
   the image-style option.

## Where it lives in the admin menu

The module has no page of its own. You set it up on core's **Text formats and editors**
screen at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by editing a CKEditor 5 text format.
