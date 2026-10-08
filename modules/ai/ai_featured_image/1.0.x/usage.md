<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Featured Image auto-generates a node's featured image with OpenAI DALL-E when the node is saved without one.

---

AI Featured Image is a small hook-driven module for Drupal 11. When a node of an enabled content type is saved and its configured image field is empty, an `hook_entity_presave()` handler builds a text prompt from the node (with `[title]` and `[body]` placeholders), calls the OpenAI image-generation (DALL-E) endpoint directly, downloads the generated PNG into `public://ai_images/` as a managed File entity, and sets it on the target image field. Configuration lives on one settings form: an enable toggle, the OpenAI API key, the enabled content types, the image field machine name, and the prompt template. It depends only on core `node` and `file`, and calls OpenAI directly rather than through the drupal/ai provider layer.

---

- Automatically fill a node's empty image field on save.
- Generate a hero/featured image for new blog posts.
- Add imagery to news articles that ship without a picture.
- Produce illustrations for government or portal content.
- Restrict automatic generation to selected content types.
- Point generation at a specific image field (e.g. `field_image`).
- Base the image prompt on the node title via `[title]`.
- Include node body text in the prompt via `[body]`.
- Customize the prompt template per site (e.g. "Illustration of: [title]").
- Store generated images as reusable File entities in `public://ai_images/`.
- Give editors a starting image they can later replace.
- Keep image generation opt-in per bundle.
- Skip nodes that already have an image (only empty fields are filled).
- Enrich content visually without a designer.
- Generate a 1024x1024 PNG per node.
- Use OpenAI DALL-E as the image provider.
- Turn automatic generation on or off globally with one checkbox.
- Provide a programmatic generator service for custom callers.
- Add default imagery during bulk content creation.
- Standardize a house image style through a shared prompt template.
