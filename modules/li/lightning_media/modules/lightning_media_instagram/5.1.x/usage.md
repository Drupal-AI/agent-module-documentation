<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Instagram is the Lightning Media component that installs an **Instagram** media type on top of the contrib Media Entity Instagram module, giving it input matching for pasted Instagram URLs, live previews on the media form, and an "Add via URL" step in the core media library.

---

The whole module is one `hook_media_source_info_alter()` plus a source subclass and a validation constraint. The hook takes the `oembed:instagram` source provided by `media_entity_instagram` and adds an `input_match` array (constraint `InstagramEmbedCode`, field types `string` and `string_long`), sets `preview => TRUE` so Lightning Media's `MediaForm` renders a live preview as the editor types, and registers `Drupal\lightning_media\Form\AddByUrlForm` as the source's `media_library_add` form. It then swaps in `Drupal\lightning_media_instagram\Plugin\media\Source\Instagram` with `Override::pluginClass()`. There is one compatibility wrinkle: when the current kernel is an `UpdateKernel` the hook also aliases the definition under the old `instagram` plugin ID, because Media Entity Instagram 3.x renamed the source and update hooks on old sites would otherwise fail on a missing plugin. Validation lives in `InstagramEmbedCodeConstraint` / `InstagramEmbedCodeConstraintValidator`. All configuration ships in `config/install/`: `media.type.instagram` using the parent module's shared `embed_code` string field, the `field_media_in_library` boolean, and default/embedded/thumbnail form and view displays, with the `media_library` view display in `config/optional/`.

---

- Add a ready-made Instagram media type in one `drush en`.
- Let an editor paste an Instagram post URL and see a live preview before saving.
- Add an Instagram post to the media library through the "Add via URL" form.
- Embed an Instagram post in an article body through the media library.
- Curate influencer posts as reusable media entities rather than pasted embed markup.
- Build a Views listing of Instagram media for a campaign landing page.
- Reference Instagram posts from a "social wall" paragraph or Layout Builder block.
- Validate a pasted Instagram URL with the `InstagramEmbedCode` constraint before saving.
- Hide unapproved posts from the media library with `field_media_in_library`.
- Give Instagram items an `embedded` view display for in-body rendering.
- Give Instagram items a `thumbnail` view display for the media library grid.
- Restrict Instagram creation to a communications role with `create instagram media`.
- Include Instagram posts in a media slideshow with Lightning Media Slideshow.
- Track which article embedded which post via Entity Usage.
- Reuse the same post across several pages without duplicating markup.
- Keep the canonical post URL in the shared `embed_code` field so it can be re-rendered later.
- Detect that a pasted string is an Instagram URL with `MediaHelper::getBundlesFromInput()`.
- Survive an upgrade from Media Entity Instagram 3.x thanks to the UpdateKernel source alias.
- Add an Instagram-only media reference field to a content type.
- Audit embedded posts by querying media entities of the `instagram` bundle.
- Translate the media item's name while keeping one shared embed code.
- Replace an ad-hoc "paste the Instagram embed code" text field with a proper media entity.
- Combine Instagram and Tweet media types on a single social media landing page.
- Give the marketing team a consistent workflow for both Instagram and Twitter content.
