<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Media Image defines the image media type the suite's components use.

---

An image media type is more than a file field: it carries alt text, a name, whatever metadata the site needs, and the view displays each context renders it through. Defining it once means a hero image, a card thumbnail and a gallery tile are the same entity rendered three ways rather than three uploads.

That single-entity property is the practical benefit. Replacing a photograph replaces it everywhere it appears; adding a credit adds it everywhere; and the media library gives editors a way to find an existing image rather than uploading a fourth copy.

Because it is a core media type, anything on the site can use it — it is not private to VLSuite components. Check dependencies before removing it.

---

- Define the image media type for components.
- Store alt text with the image.
- Render one image in several contexts.
- Replace a photograph everywhere at once.
- Add a credit to an image.
- Find an existing image in the media library.
- Avoid duplicate uploads.
- Configure view displays per context.
- Serve responsive image styles.
- Use the type outside VLSuite.
- Check dependencies before removal.
- Translate image metadata.
- Audit unused images.
- Standardise image metadata fields.
- Support editorial image workflows.
