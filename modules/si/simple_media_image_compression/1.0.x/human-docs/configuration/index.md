# Configuration

Simple Media Image Compression has one short settings form and a simple rule: when
enabled, it re‑compresses referenced JPEG media images every time a node or paragraph
is saved.

## Open the settings form

1. Log in as a user with the core **administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Simple Media Image Compression**, or navigate
   directly to `/admin/config/system/simple_media_image_compression/config`.

## The two settings

- **Enable Compression** — a checkbox that turns the whole feature on or off. While it
  is off, saving content does nothing to your images. This makes it easy to switch
  compression off temporarily — for instance during a bulk import — and back on again.
- **JPEG compression quality** — a number from **10** to **100** (default **70**),
  where 10 gives the smallest files at the lowest quality and 100 gives the largest
  files at the highest quality. The value must be numeric and within that range, or
  the form will reject it.

Click save. The values are stored in the `image_compression.qualitysettings`
configuration, so you can roll the setting out per environment through config.

## When and how compression runs

Compression happens on **node save** and **paragraph save**. To compress existing
content's images, simply **edit and re‑save** that content. On save, with compression
enabled, the module:

1. Walks the entity's fields and finds entity‑reference fields targeting the media
   **image** bundle.
2. Resolves each referenced media item's image file.
3. For files whose type is `image/jpeg` (or `image/jpg`) only, re‑encodes the file in
   place at your chosen quality. Other formats (PNG and so on) are skipped entirely.

## Important: this overwrites the original file

Compression is **lossy and destructive**. The module rewrites the original image on
disk at its real path — there is **no backup** of the file as it was before
compression. Two consequences follow:

- Keep your untouched source originals somewhere else if you may need them later.
- Re‑saving the same content repeatedly recompresses the already‑compressed JPEG,
  degrading it a little more each time. Avoid unnecessary repeated saves of the same
  images.

There are no anonymous endpoints, external calls, or secrets involved — the module
only ever touches images that have already been uploaded, behind the administrator‑
only settings form.
