Adds a Schema.org `ImageObject` group to Metatag, outputting JSON-LD describing images with their dimensions and metadata.

---

A companion submodule of Schema.org Metatag. It registers a Metatag group `schema_image_object` with a Tag plugin per ImageObject property, extending `SchemaNameBase` (and the base `SchemaImageObjectBase`). After enabling, the ImageObject tags appear under the site's Metatag configuration and pull values from image fields via tokens. On render, Schema.org Metatag emits them in the page's `application/ld+json` script. Useful for licensable images, galleries and any page where richer image metadata aids search. Requires `schema_metatag`.

---

- Add `ImageObject` JSON-LD to image and gallery pages.
- Provide the `contentUrl` of the image file.
- Set the image `url`.
- Give the image a `name`.
- Add a `description` / caption.
- Declare pixel `width` and `height`.
- Add `aggregateRating` where images are rated.
- Include a `review`.
- Set a stable `@id`.
- Choose the `@type` (ImageObject).
- Describe licensable stock images.
- Enrich nested image data for other Schema types.
- Improve image search metadata.
- Configure globally, override per content type.
- Keep values in sync with media fields via tokens.
- Validate output in Google's Rich Results Test.
