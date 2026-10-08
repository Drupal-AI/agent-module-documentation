Adds field formatters that place a "Download All Files" link on an entity-reference (media) field, letting a visitor download every file behind the referenced media items as one ZIP archive.

---

Media Download All extends the four core entity-reference field formatters (Thumbnail, Rendered entity, Label, Entity ID) with "(MDA)" variants that render exactly like the core formatter but append a single "Download All Files" link. Clicking that link hits a controller route that walks the referenced media entities, collects every file-reference field on each media item, and compresses those files into a `.zip` using a batch process. The archive is written to `private://media_download_all/`, cached per entity+field, and streamed back as an attachment; a cache-tags invalidator deletes the stale ZIP whenever the source entity changes. It works with any entity type that has an entity-reference field pointing at media, not just nodes, and it supports Aliyun OSS (flysystem) remote file storage in addition to local files.

---

- Let visitors download all photos attached to a gallery node as one ZIP instead of clicking each file.
- Bundle every document referenced by a "Attachments" media field on an article into a single archive.
- Provide a one-click "download everything" link on a product page's media gallery.
- Package all files of a press-kit node (logos, images, PDFs) for journalists.
- Offer course materials (slides, handouts) referenced from a media field as one download.
- Give members a single-archive download of event photos referenced by a media field.
- Attach a "Download all" link under a rendered-entity display of referenced media documents.
- Bundle report attachments referenced on a report content type for offline review.
- Let editors grab all media of an entity in one archive for migration or backup checks.
- Provide a download-all link on a taxonomy term page that references media items.
- Package brand assets (multiple image styles' originals) referenced by a media field.
- Offer a single ZIP of all audio files referenced by a podcast episode's media field.
- Bundle all supporting files of a grant application entity for reviewers.
- Add a download-all link to a user profile entity that references media files.
- Provide archive download of all images in a real-estate listing's media gallery.
- Bundle floor plans and photos referenced by a property media field into one file.
- Let customers download all invoices/receipts referenced on their order entity's media field.
- Package meeting minutes and slides referenced by a meeting node into one archive.
- Offer a one-click download of all lab result files referenced on a record entity.
- Use the private file system so temporary ZIP archives are not publicly guessable.
- Serve download-all archives from Aliyun OSS-backed media without local temp copies of remote data.
- Provide a download-all link on the Thumbnail display of a media gallery field.
- Add the link to the Label or Entity-ID display when a thumbnail display is not wanted.
- Regenerate the archive automatically after the source entity's media set is edited (cache invalidation).
