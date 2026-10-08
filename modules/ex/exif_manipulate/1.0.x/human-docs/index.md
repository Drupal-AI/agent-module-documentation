# Exif Manipulate — manual setup guide

**Exif Manipulate** (`exif_manipulate`) strips EXIF metadata out of images when
they're uploaded. Modern cameras and phones embed a surprising amount of data in
the photos they produce — camera model, timestamps, and most sensitively the
**GPS coordinates where the picture was taken**. Publishing images with that
metadata intact can quietly leak private information about your users and the
subjects of their photos. Exif Manipulate removes it before the images are stored
and served.

It's a privacy control, plain and simple. Enable it wherever people upload images
that will be shown publicly — avatars, galleries, submissions — so you don't
inadvertently publish location and device data. The module is designed with
extension points in mind, so it can grow beyond stripping unwanted data toward
inserting new data as well. One deliberate exception: the **EXIF orientation**
information (which tells software how to rotate the image) is left untouched, so
photos still display the right way up.

The module needs the `fileeye/pel` PHP library, which Composer installs for you
automatically. It has no other module dependencies and supports Drupal 10 and 11.
The maintainers also recommend pairing it with the
[EXIF orientation](https://www.drupal.org/project/exif_orientation) module, which
rotates uploaded files according to their rotation metadata.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the PEL library) and enable it.
2. [Configuration](configuration/index.md) — the optional conversion form for
   retroactively cleaning images that were already uploaded.

## Where it lives in the admin menu

Once enabled, Exif Manipulate cleans new uploads automatically — there's nothing
you must configure for that to work. It does provide an optional **conversion
form** at **Configuration → Media → Exif Manipulate**
(`/admin/config/media/exif_manipulate`), which lets you apply the same cleaning
retroactively to images already stored in certain file‑system locations. See
[Configuration](configuration/index.md).
