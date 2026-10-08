<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Representative Image lets you declare, per entity bundle, which image best represents an entity, then use that choice through field formatters, a token, or a service.

---

Install the module (Composer or the UI) and add a **Representative Image** field to a bundle — a content type, but also any fieldable entity such as a taxonomy term, user, comment or media type. The field itself has no upload widget; you configure it under **Manage fields → (the field) → settings** by choosing a **source field** (an existing image field, or an entity-reference/media field on the same bundle) and a **fallback behavior** for when that field is empty: *first image found on the entity*, *default image*, or *first or default*. When the source is a media or entity reference, the module follows the reference and reads the target entity's own representative image, so image fields and media references behave the same. You then consume the result three ways. Under **Manage display** the `representative_image` formatter renders it with any image style and optional link (to content or file); on a plain entity-reference field the `entity_representative_image` formatter renders each referenced entity's representative image with an image formatter you pick. A token `[node:representative_image]` (registered on every entity type) resolves to the image's URL — feed it into a Metatag `og:image` pattern so social previews are consistent per content type. From code, call `\Drupal::service('representative_image.picker')->getImageFromEntity($entity, $attributes)` to get the image URI plus width/height/alt/title. Modules can adjust the chosen image via `hook_representative_image_alter()` (for example to backfill missing alt text), and a Drupal 7 upgrade path is provided via the `d7_representative_image_field_*` migrations.

---

- Declare, per content type, which image represents a node.
- Set a consistent `og:image` for social sharing via a token.
- Provide a token (`[node:representative_image]`) for a listing thumbnail.
- Fall back to the first image found on the entity when the chosen field is empty.
- Fall back to a configured default image when no image exists.
- Chain "first image, otherwise default" as the fallback.
- Point the field at an existing image field on the bundle.
- Point the field at a media reference and resolve through to the media's image.
- Follow an entity reference to the target entity's own representative image.
- Render the representative image with an image style in a display mode.
- Link the rendered image to the host content or to the image file.
- Add the field as a column in a view spanning multiple content types.
- Render referenced entities' representative images with the `entity_representative_image` formatter.
- Use the image in a Metatag Open Graph pattern.
- Feed the token into a mail template or email digest.
- Feed the token into an RSS/Views field rewrite.
- Standardise thumbnails and preview images across bundles.
- Attach the field to non-node entities (terms, users, comments, media).
- Fetch the image URI from PHP with the `representative_image.picker` service.
- Read the image's width, height, alt and title in one call.
- Alter the chosen image (e.g. backfill alt text) via `hook_representative_image_alter()`.
- Provide a single, bundle-level answer so consumers stop guessing which image to use.
- Reduce bespoke image-selection code across a site.
- Migrate representative image settings from a Drupal 7 site.
