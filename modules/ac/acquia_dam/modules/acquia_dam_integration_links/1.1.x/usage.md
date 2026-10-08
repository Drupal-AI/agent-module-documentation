<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enhanced Integration Links deepens Acquia DAM's asset-usage tracking: it scans all content entities on save for DAM assets embedded in entity-reference fields, paragraphs, and WYSIWYG entity embeds, and registers accurate integration links back to the DAM.

---

This submodule of Acquia DAM has no UI or configuration — it works automatically once enabled. Where the parent module's `IntegrationLinkRegister` tracks direct **media** entities, this submodule adds "deep discovery": on `hook_entity_insert`/`update`/`delete` it runs a set of pluggable **asset detectors** (collected via the `asset_detector` service tag) over every eligible content entity to find DAM assets referenced anywhere in its fields. Three detectors ship: `MediaReferenceAssetDetector` (entity-reference fields to media), `EntityEmbedTextDetector` (assets embedded in rich-text), and `ParagraphsAssetDetector` (recursive descent through nested paragraphs). It compares the old and new asset sets, then delegates to the parent's `IntegrationLinkRegister` to queue registration or removal of links via the `acquia_dam_integration_links` queue (processed by the parent's queue worker and cron). Media and paragraph entities are skipped as top-level subjects (they are handled through their host entity), keeping work scoped to eligible content. Because it only enriches discovery and hands the actual API communication to the parent, it adds per-save scanning overhead but no new config surface; the real link registration still requires a live DAM connection.

---

- Track DAM images referenced from a node's entity-reference "hero image" field.
- Detect DAM assets embedded in body text via Entity Embed and register their usage.
- Discover DAM media nested several paragraphs deep on a landing page.
- Keep Acquia DAM's usage report accurate for complex, structured content.
- Automatically remove integration links when an asset is unreferenced after an edit.
- Re-register links with updated context when a host entity's title changes.
- Cover all content entity types (nodes, terms, custom entities), not just media.
- Enable accurate "where is this asset used?" answers in Widen for a Paragraphs-based site.
- Avoid missing asset usage that the parent module's media-only tracking would overlook.
- Queue link registration asynchronously so entity saves stay responsive.
- Process discovered links in the background with `drush queue:run acquia_dam_integration_links`.
- Extend detection to a custom field structure by adding an `asset_detector`-tagged service.
- Skip performance cost on simple sites by leaving the submodule disabled.
- Deduplicate assets found across multiple fields before registering links.
- Track DAM assets across revisions of structured content.
- Maintain integration links for media referenced through entity_reference_revisions.
- Ensure deleting a node removes its assets' integration links from the DAM.
- Support editorial workflows where assets move between paragraphs over time.
- Give DAM administrators confidence that Drupal usage data is complete.
- Pair with the parent module's Drush integration-link commands for bulk reconciliation.
