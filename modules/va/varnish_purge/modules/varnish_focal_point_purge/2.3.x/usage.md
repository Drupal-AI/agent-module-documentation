Varnish Focal Point Purger is a submodule of Varnish Purger that flushes all image-style derivatives of a file from Varnish when its Focal Point crop entity is updated, using `URIBAN` HTTP requests.

---

Varnish Focal Point Purger implements `hook_entity_update()` and acts only on entities whose bundle is `focal_point` (the Focal Point module's crop entity). When such an entity is saved, it loads the associated file (from the crop's `entity_id`), builds the URL of every image-style derivative of that file (`ImageStyle::loadMultiple()` + `buildUrl()`), and fires a concurrent `URIBAN` HTTP request per derivative URL (Guzzle `Pool`, concurrency 10). This bans the stale cropped variants in Varnish so a new focal point takes effect immediately. Like its sibling `varnish_image_purge`, it discovers Varnish hostname/port from the existing `varnish_purger.settings.*` config entities and needs the Varnish VCL to handle the `URIBAN` method (example snippet is in the module's help page). It has **no configuration and no admin page** — enable it and it works. It depends on `varnish_purger` and `purge`, and is meant for sites using the Focal Point / Crop module.

---

- Purge image-style derivatives from Varnish when a Focal Point crop is repositioned.
- Ensure a new focal point takes effect immediately on Varnish-cached responsive images.
- Send `URIBAN` requests per derivative URL so only the affected image variants are banned.
- React automatically to `focal_point` crop-entity updates via `hook_entity_update()`.
- Regenerate all cropped variants of the underlying file after a focal-point change.
- Reuse hostname/port from an existing `varnish` purger — no extra connection config.
- Run derivative purges concurrently (up to 10 at a time) for fast invalidation.
- Keep cropped thumbnails and hero images consistent with editor-set focal points.
- Complement `varnish_image_purge`, which handles image-field changes on general entities.
- Add a `URIBAN` handler to your Varnish VCL using the example snippet in the module help.
- Avoid stale crops after content editors adjust the focal point of an image.
- Work on any Drupal 8/9/10/11 site running Focal Point behind Varnish.
- Enable instant image-crop freshness with zero configuration (`drush en varnish_focal_point_purge`).
- Target only focal-point changes, leaving other entity updates to `varnish_image_purge`.
- Combine with Varnish Purger's page/tag invalidation for full Varnish cache coverage.
