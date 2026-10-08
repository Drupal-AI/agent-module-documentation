# Media PDF Thumbnail — manual setup guide

**Media PDF Thumbnail** (`media_pdf_thumbnail`) turns a page of a PDF into a real
preview image and uses it as the thumbnail for a Media entity — so a document in
your media library shows an actual cover instead of a generic PDF file icon.

You switch it on per media type by choosing a special image field formatter,
**Media PDF Thumbnail Image**, on the media entity's thumbnail field. For each media
type you tell it which file field holds the PDF, which page to render (the first
page by default), whether to output JPG or PNG, which image style to apply, and how
the image should link (to the media page, the file, or the PDF itself). When the
field is displayed, the module rasterises the chosen page and caches the result, so
each PDF page is rendered only once and re-used afterwards. The original thumbnail
value is never changed — the preview is only substituted on display.

Because it renders PDFs, this module has real server requirements: the **imagick**
PHP extension and the **spatie/pdf-to-image** library, plus PHP 8.2+. Generation can
run inline as the field renders, or be deferred to cron via a queue for large
batches. An admin section under *Configuration → Media → Media PDF thumbnail* lists
every generated image and offers Settings (where the images are stored), Queue, and
Clean/Purge tools. The module also provides tokens for embedding a rendered
thumbnail elsewhere, an alter hook, and a permission for viewing thumbnails of
private files. It depends on core's **Media** module and has no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the imagick / spatie library
   requirements, install with Composer, and enable the module.
2. [Configuration](configuration/index.md) — selecting the formatter per media
   type, its options, the admin section, storage settings, queue, and permissions.

## Where it lives in the admin menu

Two places matter. You **turn it on** per media type under **Structure → Media
types → (your type) → Manage display**, by choosing the *Media PDF Thumbnail Image*
formatter on the thumbnail field. You **manage** generated images and storage under
**Configuration → Media → Media PDF thumbnail**
(`/admin/media-pdf-thumbnail/settings/list`), which has Settings, Queue and Clean
tabs. Both are covered in [Configuration](configuration/index.md).
