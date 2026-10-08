<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Original image with style replaces the originally uploaded image file with a version processed through a chosen image style, so the stored source file itself is resized/optimized rather than only its on-the-fly derivatives.

---

It adds a third-party setting ("Apply style to image after upload") to each image field's configuration form. On `hook_entity_presave`, for every image field that has a style configured, newly added files (those not already present on the original entity) are processed: the selected image style's effects are written back over the source URI via `createDerivative($uri, $uri)`, the file entity is re-saved, and the item's width/height are updated from the new dimensions. Files already referenced on the previous revision are skipped so images are not reprocessed on every save.

Operational notes: this is a destructive, in-place transform — the original full-resolution upload is not retained once overwritten, so keep this in mind for archival needs. The module has no routes, permissions or services; it operates purely through field third-party settings and entity hooks, so it introduces no request-facing attack surface. Configuration is per image field on its settings form.
---
- Downscale large uploads to a maximum size on save to save disk space.
- Apply an image style's effects permanently to the stored source file.
- Optimize/strip images at upload time via an image style.
- Update stored width/height after transforming the original file.
- Configure the transform per image field via a third-party setting.
- Avoid keeping huge originals when only a bounded size is ever needed.
- Reprocess only newly added images, not existing ones, on entity save.
- Enforce a consistent maximum resolution across uploaded images.
- Reduce storage costs for user-generated image content.
- Normalize aspect ratio/crop of source images using a crop style.
- Apply the same style pipeline to originals as to derivatives.
- Cut bandwidth by shrinking the base file, not just responsive variants.
- Use with any fieldable entity type that has an image field.
- Combine with any image style defined on the site.
- Skip reprocessing images carried over from a previous revision.
- Bake watermark/scale effects into the stored original.
- Simplify media pipelines that don't need the full-res original.
