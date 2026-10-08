Media PDF Thumbnail generates an image from a page of a PDF file (the first page by default) and uses it as the thumbnail for a Media entity, replacing the default file icon with a real preview rendered on display.

---

The module adds an image field formatter, **Media PDF Thumbnail Image**
(`media_pdf_thumbnail_image_field_formatter`), that you select on the Media entity's thumbnail
field in a view display. Per media bundle you choose which file field holds the PDF, which page
to render, the output format (`jpg`/`png`), an image style, and how the image links (content /
file / PDF file, with download/target/rel attributes). When the field renders, the module uses
the **imagick** PHP extension and the **spatie/pdf-to-image** library to rasterise the chosen
page and stores the result in a `pdf_image_entity` content entity (a lookup that maps the source
PDF + page + format to a generated image file), so the image is generated once and re-used; the
original thumbnail value is never modified, only replaced on display. Generation can run inline
or be deferred to cron via a queue (`PdfImageEntityGenerateQueue`). An admin section under
*Configuration → Media → Media PDF thumbnail* (the `view.pdf_image_entity.list` view) lists all
generated PDF-image entities and offers **Settings** (custom public/private destination URIs),
**Queue**, and **Clean/Purge** forms. It also exposes tokens
(`[media_pdf_thumbnail:<field>:<page>:<format>:image_uri|image_id|render:<style>[:link_pdf]]`),
a hook (`hook_media_pdf_thumbnail_image_render_alter()`) to alter the rendered image, and a
private-file access permission. Because it depends on imagick + spatie/pdf-to-image and a real
PDF, evals should be grounded in its config, formatter selection, permissions and the
`pdf_image_entity`/view rather than in actually rasterising a PDF.

---

- Show a real preview image instead of a generic icon for PDF media items.
- Render the first page of a PDF as a media thumbnail.
- Render a specific page (e.g. a cover on page 2) as the thumbnail.
- Output the thumbnail as JPG or PNG per media bundle.
- Apply an image style (e.g. `medium`, `thumbnail`) to the generated image.
- Link the thumbnail to the PDF file so clicking it opens the document.
- Link the thumbnail to the media/content page or the raw file instead.
- Add `download`, `target` and `rel` attributes to the linked thumbnail.
- Configure different PDF file fields per media bundle.
- Defer thumbnail generation to cron via the queue for large/batch imports.
- Regenerate thumbnails after replacing a PDF by clearing caches.
- List and audit all generated PDF-image entities in the admin view.
- Purge/clean stored PDF-image entities and their files.
- Store generated images in a custom public directory (`public://pdf-thumbnails`).
- Store generated images in a private directory (`private://pdf-thumbnails`).
- Restrict who can view private PDF thumbnails via a permission.
- Embed a rendered PDF thumbnail in text via a token in another field.
- Get a PDF thumbnail's file URI or file id via token for use in code.
- Output a rendered, image-styled PDF thumbnail linked to the PDF via token.
- Alter the generated image's alt/attributes with a render-alter hook.
- Use PDF previews in a Views listing of media documents.
- Provide document previews in a resource library or downloads page.
- Show catalogue/brochure cover previews sourced from uploaded PDFs.
- Avoid manually creating cover images for every uploaded document.
