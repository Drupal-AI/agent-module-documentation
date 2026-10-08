# Image Resizer — manual setup guide

**Image Resizer** (`image_resize`) resizes and converts the **original** image files
on your site — both existing uploads and new ones — down to a lower resolution
and/or a more modern format such as WebP or AVIF. Editors routinely upload what
their camera or designer gave them: a 6000‑pixel JPEG for a 400‑pixel slot. Image
styles fix the *display* size, but the original stays in the filesystem at full size
and, on a site with years of uploads, that is the bulk of your storage and backups.
Image Resizer addresses the source instead of the presentation.

You configure which MIME types to convert, one of two resize modes (**minimal** —
images stay at least the given size; **maximal** — images stay below the given
size), and the target format. With the **ImageMagick** toolkit you can also set a
specific conversion quality (recommended over GD for that reason). A minimum file
size skips tiny images. Processing runs through Drupal's **queue** — you can add
existing images to the queue and let cron (or `drush queue:run image_resize`) work
through them; the same settings are also applied automatically to newly created
images via cron. It depends on core **File** and **Image**.

> **Warning — this is irreversible.** The module converts the *original* files, and
> the process cannot be undone. Resizing discards pixels permanently, and format
> conversion changes what a download gives people (AVIF, in particular, isn't
> universally supported outside browsers). **Back up before testing**, and if the
> site is also an archive or anyone may later need print‑resolution masters, keep
> those elsewhere and resize only what the web serves. This release is a **beta**
> (1.0.0‑beta1) — test against a copy with representative images first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the resize/convert settings, and how to
   queue and process images.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Image Resizer**
(`/admin/config/media/image-resizer`), which requires the *Administer site
configuration* permission. That page is also where you can add existing images to
the processing queue.
