# Media Thumbnails PDF — manual setup guide

**Media Thumbnails PDF** (`media_thumbnails_pdf`) makes PDF files in your media
library look like the documents they are. Instead of a generic file icon, each
PDF media entity gets a real thumbnail: the module renders the **first page** of
the PDF as a JPG image and uses that as the media entity's preview.

It is a plugin for the [Media Thumbnails](https://www.drupal.org/project/media_thumbnails)
framework — it doesn't work on its own, and it doesn't try to reinvent anything.
When a PDF media entity is saved, the Media Thumbnails framework notices the file
is a PDF (`application/pdf`) and hands it to this plugin, which copies the file to
a temporary location, opens its first page with ImageMagick, flattens any
transparency onto a white background, scales the image down to the configured
thumbnail width, converts it to JPG, and stores it as the media entity's
thumbnail. The result is a proper cover-page preview in media grids, the media
library, Views, and image-style-driven displays — with no manual upload from your
editors.

Because the heavy lifting (rasterizing PDF pages) is done by ImageMagick, this
module has two hard technical requirements: the **ImageMagick PHP extension**
(`ext-imagick`) and, in practice, a **Ghostscript** delegate that lets ImageMagick
read PDF pages. If the `imagick` extension isn't loaded, Drupal's status report
flags the module with an error and no thumbnails are generated. See
[Installation](installation/index.md) for how to check for these.

Media Thumbnails PDF has **no settings of its own** (`configure: null`). The one
setting that affects it — the thumbnail **width** (default 500px) — belongs to
the parent Media Thumbnails module. There are no permissions and no Drush commands
to learn.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the plugin's mime registration and how the
thumbnail is generated — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   confirm ImageMagick and Ghostscript are available, and enable it.

## Where it lives in the admin menu

Media Thumbnails PDF has **no page of its own**. The only relevant settings form
belongs to the parent module, at **Configuration → Media → Media thumbnails**
(`/admin/config/media/media_thumbnails`), where you can set the global thumbnail
**width** that PDF thumbnails are scaled to.

## How to use it

Once the module is enabled (and ImageMagick with a Ghostscript delegate is
available), there is nothing to switch on — it just works:

1. Upload or edit a PDF as a media entity, or import PDFs into the media library
   as usual.
2. On save, the first page is automatically rendered and stored as the media
   entity's thumbnail. Updating the media entity regenerates the thumbnail;
   deleting it removes the generated image.
3. *(Optional)* To change how large the generated thumbnails are, adjust the
   **width** on the parent module's settings form
   (`/admin/config/media/media_thumbnails`) or from the command line:

   ```bash
   drush cget media_thumbnails.settings width
   drush cset media_thumbnails.settings width 250 -y
   ```

That's the whole workflow — a visible, automatic cover image for every PDF in
your media library.
