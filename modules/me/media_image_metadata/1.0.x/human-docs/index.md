# Media Image Metadata — manual setup guide

**Media Image Metadata** (`media_image_metadata`) reads the metadata that
photographers and cameras embed inside image files — **EXIF**, **IPTC**, and
**XMP** — and makes it available to populate fields on your media entities. Instead
of retyping a caption, capture date, photographer, or copyright line that is
already baked into the file, you can have the media entity pick it up automatically.

To spare you from memorising where each value lives across the three standards, the
module provides a sensible **mapping** for the most commonly used attributes. For a
given attribute it tries the standards in a priority order and falls back as
needed — for example, *caption* is read first from IPTC (`2#120`), then XMP
(`dc:description`), then EXIF (`ImageDescription`); and *title* falls back to the
filename if nothing else supplies a value. If your images store data somewhere
unusual, a developer can adjust the mapping with the
`hook_media_image_metadata_alter()` hook in a custom module.

> **Privacy caveat — read this before exposing metadata.** Embedded image metadata
> can contain sensitive information, most notably **GPS geolocation** (exactly where
> a photo was taken) and other personal details. Decide deliberately which EXIF/IPTC
> fields you extract and display, and be careful not to publish location or personal
> data unintentionally. For public images, consider **stripping GPS metadata**
> before or during publication.

This is a metadata‑mapping feature; it reads and maps data and plays no part in
access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (if you need EXIF) confirm the PHP EXIF extension.

There is **no dedicated settings form** — the module works through its built‑in
mapping, which developers can customise via the alter hook described above. How the
extracted values reach your media fields is covered under "How to use it" below.

## How to use it

1. Make sure your **image media type** has fields for the metadata you care about
   (for example caption, capture date, photographer, copyright).
2. With the module enabled, the embedded metadata from an uploaded image becomes
   available to fill those fields according to the module's mapping.
3. Review which attributes you actually want to store and show — and keep the
   privacy caveat above in mind for any GPS/location data.
4. Need to read metadata the default mapping doesn't cover? Implement
   `hook_media_image_metadata_alter()` in a small custom module to redirect an
   attribute (for instance, using IPTC "Special Instruction" as the caption).
