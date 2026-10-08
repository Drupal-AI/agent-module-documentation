Varnish Image Purge is a submodule of Varnish Purger that flushes an entity's image-style derivatives from Varnish whenever the entity is updated, by sending `URIBAN` HTTP requests for each derivative URL.

---

Varnish Image Purge implements `hook_entity_update()`: when a content entity is saved, it finds every image field on that entity, builds the URL of each image-style derivative (via `ImageStyle::loadMultiple()` and `buildUrl()`), and fires a concurrent `URIBAN` HTTP request per derivative URL through Guzzle (concurrency 10). This bans the cached image variants in Varnish so edited/replaced images are regenerated. It provides a small config form at `/admin/config/development/varnish_image_purge` (route `varnish_image_purge.configuration`, permission "administer site configuration") where you tick which entity-type bundles should trigger image purging; if none are selected, **all bundles of all content entity types** are purged. Its selections are stored in the `varnish_image_purge.configuration` config object under `entity_types`. It reads hostname/port from the existing `varnish_purger.settings.*` config entities (matched by a `LIKE` query on config names). For it to work you must configure Varnish to handle the `URIBAN` request method (the module's help text ships an example VCL snippet that bans `req.http.host` + `req.url` and returns a synthetic 200). It depends on `varnish_purger` and `purge`.

---

- Automatically purge an entity's image-style derivatives from Varnish when the entity is saved.
- Regenerate cropped/scaled image variants after an editor replaces an image on a node.
- Restrict image purging to specific entity-type bundles via the config form.
- Purge images across all content entity types/bundles by leaving the selection empty (the default).
- Send `URIBAN` requests per derivative URL so only image variants are banned, not whole pages.
- Configure which bundles trigger purging at `/admin/config/development/varnish_image_purge`.
- Keep Varnish-cached responsive-image variants in sync with the source image.
- Ban every image style of every image field on the updated entity in one pass.
- Run purge requests concurrently (up to 10 at a time) for fast invalidation.
- Reuse an existing `varnish` purger's hostname/port configuration — no extra connection setup.
- Add a `URIBAN` handler to your Varnish VCL using the example snippet in the module help.
- Avoid stale thumbnails/cover images after media or content edits.
- Purge derivatives only for fieldable content entities (the module skips non-fieldable ones).
- Skip entities with no image fields automatically (no wasted requests).
- Combine with the main Varnish Purger page/tag invalidation for full Varnish cache coverage.
- Target a multi-purger setup: it iterates every configured `varnish_purger.settings.*` instance.
- Give editorial teams instant, correct image updates on a Varnish-fronted site.
