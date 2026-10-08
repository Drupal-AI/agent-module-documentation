# EXIF Removal — manual setup guide

**EXIF Removal** (`exif_removal`) is a privacy‑focused module that automatically
strips sensitive metadata out of uploaded images. Cameras and phones embed data
in the photos they produce — GPS location, device information, and timestamps —
and any of that can expose personal information if the images are published. EXIF
Removal takes it out before the images are stored and served.

The module works silently in the background during the upload process. Whenever a
user uploads an image through any Drupal form — content creation, user pictures,
the media library, and so on — it intercepts the upload, reprocesses the image to
remove the embedded metadata, and then lets the upload finish normally. There are
no forms to fill in and nothing for editors to remember.

Under the hood it uses PHP's GD library to re‑encode JPEG images (at quality 80, a
well‑regarded balance of file size and visual quality), which produces a clean
copy with the EXIF data removed. If you also have the
[Image Effects](https://www.drupal.org/project/image_effects) module installed and
are using the ImageMagick toolkit, it uses ImageMagick's `strip` operation
instead. It has no module dependencies of its own, sits in the **Media** package,
and supports Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page and no settings** — the module protects uploads
automatically the moment it's enabled.

## Where it lives in the admin menu

EXIF Removal adds no admin page and has nothing to configure. Enabling it is all
it takes: from then on it cleans every image uploaded through a Drupal form.

## How to use it

Just enable the module. Because it hooks into the standard file‑upload pipeline,
it applies everywhere images are uploaded — content fields, user pictures, and the
media library alike — with no per‑field setup. If you want to protect images that
were uploaded *before* you enabled it, that's outside this module's scope; look at
a companion tool such as [Exif Manipulate](https://www.drupal.org/project/exif_manipulate),
which offers a retroactive conversion form.
