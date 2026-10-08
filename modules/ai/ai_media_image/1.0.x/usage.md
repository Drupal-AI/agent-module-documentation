<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Media Image adds a "Generate Image with AI" option to Drupal's media image add forms: an editor writes a text prompt, the module asks the AI module's configured text-to-image provider for an image, previews it, and saves the result as an ordinary `image` media entity in the Media Library.

---

The module builds on the **AI** (`ai`) module and core **Media Library**. AI supplies the provider abstraction and the `text_to_image` operation, so the model choice and its API key are configured once in AI (`/admin/config/ai/settings`) rather than here — this module only consumes that default. Via `hook_form_alter` it injects an `image_source` select (Upload vs. Generate with AI) plus a prompt textarea and the AI provider/model options into `media_image_add_form` and the Media Library upload/dropzone add forms, but only for users holding the `generate image with ai` permission and only for the `image` media type. Clicking "Generate Image" calls `ai.provider`'s `textToImage()` and takes the returned binary directly from the normalized response (no URL is fetched), showing an inline base64 preview and a required alt-text field pre-filled from the prompt. Saving writes the bytes to `public://ai_generated_image_<uniqid>.jpg` and creates the media entity, redirecting to the media collection (or updating the library in the AJAX flow). The module's own settings form at `/admin/config/ai/ai_media_image` (permission `administer ai`) exposes a single toggle, `provider_configuration_open`, controlling whether the provider-configuration fieldset starts expanded. Each generation is a live, billable provider call, so granting `generate image with ai` is effectively a spend decision, and generated images arrive without meaningful alt text, so the accessibility obligation stays with the editor. Release stands at 1.0.0-alpha4; core requirement `^10.2 || ^11`.

---

- Generate an illustration from a text prompt straight into the Media Library.
- Add AI generation as an alternative to uploading on the media image form.
- Create placeholder or concept imagery for a draft page.
- Produce a hero image without sourcing stock photography.
- Insert a generated image into a Media Image field on a content edit screen.
- Restrict who may generate images to specific roles via a permission.
- Reuse the site's single configured AI text-to-image provider everywhere.
- Prototype a design using generated imagery.
- Generate social sharing or campaign-concept images.
- Populate a media library quickly during a site build.
- Iterate on an image by editing the prompt and regenerating.
- Support an editorial team that has no in-house designer.
- Force generated images to save as safe `.jpg` files under public files.
- Keep generated results as normal media entities (image styles, usage, library all work).
- Require editors to enter alt text before an AI image can be saved.
- Choose the model parameters per generation from the provider options form.
- Limit output to one image per generation to control cost.
- Set the provider-configuration fieldset to open or collapsed by default.
- Point editors to AI module settings when no default text-to-image model is set.
- Give editors imagery for a concept when no photo exists.
- Generate consistent iconography from repeatable prompts.
- Avoid stock-photo licensing for internal or low-stakes pages.
