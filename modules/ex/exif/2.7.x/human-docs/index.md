# Exif — manual setup guide

**Exif** (`exif`) reads the EXIF, IPTC, and XMP metadata embedded in uploaded
JPEG images — camera make and model, exposure settings, shot date, GPS
coordinates, IPTC keywords, XMP title/artist, and more — and copies it into
Drupal fields on your nodes, media entities, or files. That lets you display
photo metadata, filter on it in Views, or turn keywords into taxonomy terms,
without editors typing any of it by hand.

You use the module in three moves: pick an extraction backend and tick which
content types / media types / file types to scan on the settings page, add
fields to those bundles, and assign each field one of the module's form widgets
bound to an image field and a metadata tag. When an entity is saved, Exif reads
the linked image and fills the fields for you — with special handling for text,
date, and taxonomy‑reference fields (it can even auto‑build a
`section > tag > value` term hierarchy).

The module depends on core's **File**, **Image**, and **Taxonomy** modules
(enabled for you), and works on Drupal 9, 10, and 11. It has no submodules. Two
things worth knowing up front: only **JPEG** is supported, and if you need **GPS**
data you should use ImageMagick as your image toolkit (the GD toolkit strips GPS
tags).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the reader
services and API — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose a backend, enable bundles,
   add fields with an Exif widget, and use the helper/sample pages.

## Where it lives in the admin menu

The settings, helper, and sample pages are under **Configuration → Media → Exif**
(`/admin/config/media/exif`), gated by the **Administer image metadata**
permission. The widgets are assigned on each bundle's **Manage form display**
tab.

## How to use it

Enable the module, open the Exif settings page and pick your extraction backend
and the bundles to scan, then add fields to those bundles and assign an Exif
widget to each — binding it to an image field and a metadata tag. On save, the
metadata is read and written into the fields. The
[Configuration](configuration/index.md) page walks through each step, the three
widgets, and the naming convention that maps field names to tags.
