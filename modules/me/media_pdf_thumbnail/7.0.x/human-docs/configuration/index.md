# Configuration

There are two parts to setting up Media PDF Thumbnail: **turning it on** per media
type (choosing the formatter and its options), and the **admin section** where you
control storage, the generation queue, and clean-up.

## 1. Turn it on for a media type

The module works by swapping the thumbnail field's display formatter. Do this per
media type:

1. Go to **Structure → Media types → (your type, e.g. Document) → Manage display**.
2. Find the **Thumbnail** field.
3. Change its **Format** to **Media PDF Thumbnail Image**.
4. Click the gear/settings icon to open the formatter options (below), set them,
   and **Update**, then **Save**.

The same formatter can also be chosen on a media reference field's display, and it
is offered in the Views UI when you display a media thumbnail there.

### Formatter options (per media type)

Because one display can render several media types, the settings form shows a
fieldset per media type (plus a default). For each type you set:

- **File field** — which file field on that media type holds the PDF. Only
  file-type fields are offered; a non-PDF file is ignored.
- **Page** — the page number to render as the thumbnail (default **1**, the first
  page). Set it to `2` for a cover on page two, and so on.
- **Image format** — **jpg** or **png** for the generated image.
- **Image style** — an image style to apply to the generated image (e.g.
  `thumbnail`, `medium`).
- **Link image to** — where clicking the thumbnail goes: the media/**content** page,
  the raw **file**, the **PDF file**, or nothing.
- **Download / Target / Rel** — optional `download`, `target` (e.g. `_blank`) and
  `rel` attributes added to that link.
- **Use cron** — defer generation of this type's thumbnails to the cron queue
  instead of generating them inline when the field first renders. Useful for large
  imports.

After changing formatter settings, run a cache rebuild (`drush cr`) so displays
regenerate.

## 2. The admin section

Under **Configuration → Media → Media PDF thumbnail**
(`/admin/media-pdf-thumbnail/settings/list`) there are four tabs. All the form tabs
require the **Administer media pdf thumbnail** permission.

- **PDF image entities** — lists every generated preview image the module has
  cached. Each generated image is stored as a small record that maps a source PDF +
  page + format to the image file it produced, so the same page is never rendered
  twice.
- **Settings** — where generated images are stored (see below).
- **Queue** — manage the pending generation queue (used when *Use cron* is on).
- **Clean** — purge stored generated images and their files (for example after
  replacing PDFs), so they regenerate fresh.

### Settings tab — where images are stored

Two optional fields:

- **Public destination** — a `public://…` path where public generated images go,
  e.g. `public://pdf-thumbnails`.
- **Private destination** — a `private://…` path for private generated images, e.g.
  `private://pdf-thumbnails`.

Each value, if set, must start with `public://` or `private://`. If you leave both
empty, generated images are written **next to the source PDF file**.

## Regenerating after a PDF changes

The generated image is cached, so if you replace a PDF the old preview can linger.
Clear the cache (`drush cr`) or use the **Clean** tab to purge the stored image, and
it will be regenerated from the new file on next display.

## Permissions

The module adds several permissions (set them at `/admin/people/permissions`). The
ones you are most likely to care about:

- **Administer media pdf thumbnail** — gates the Settings, Queue and Clean forms.
- **View private pdf thumbnails** — lets a user see a generated thumbnail when the
  source is a **private** file. This is granted to the *Authenticated user* role by
  a module update; adjust it if private documents should be more restricted.

There are also add/edit/delete and view permissions for the generated PDF-image
entities themselves, for finer control.

## Tokens (optional)

Beyond the media thumbnail, the module exposes tokens so you can embed a rendered
PDF thumbnail — its file URI, its file id, or a fully rendered, image-styled image
linked to the PDF — inside another field or template. The token patterns are
documented in the [`agent/` token docs](../agent/api/tokens.md).
