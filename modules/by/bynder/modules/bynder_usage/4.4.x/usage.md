Bynder Usage reports where each Bynder asset is used on the Drupal site back to Bynder, by listening to Entity Usage events and calling the Bynder asset-usage API so the DAM knows which pages reference an asset.

---

The submodule subscribes to the [Entity Usage](https://www.drupal.org/project/entity_usage) module's events
(`UsageEventSubscriber`, registered in `bynder_usage.services.yml`): `USAGE_REGISTER`,
`DELETE_BY_SOURCE_ENTITY`, and `DELETE_BY_TARGET_ENTITY`. When a Bynder media entity gains a usage on a host
entity that has a canonical URL, it calls `BynderApi::addAssetUsage()` with the remote asset ID, the host
URL, a timestamp, and an "Added asset by user …" note — but only once per URI (it first checks
`getAssetUsages()` to avoid duplicates). When usage count drops to zero, the source entity is deleted, or the
media entity itself is deleted, it calls `removeAssetUsage()` to clean up the corresponding remote usage
records (matching by URI, and scoping deletions to this site's base URL). Paragraph host entities are walked
up to their parent to resolve a canonical URL. All Bynder API failures are caught and logged. The result is
that Bynder's "usage" view of an asset reflects real Drupal placements. Depends on `bynder` and
`entity_usage` (>= 2.x). No config, no permissions.

---

- Report to Bynder every page/entity where a Bynder asset is embedded or referenced.
- Automatically register asset usage when Entity Usage records a new reference.
- Remove the remote usage record when an asset is unreferenced (usage count hits zero).
- Clean up Bynder usages when a host node/entity is deleted.
- Remove all remote usages for an asset when its Drupal media entity is deleted.
- Deduplicate usage reporting so a given URI is only registered once per asset.
- Attribute a usage registration to the acting Drupal user in the Bynder note.
- Resolve canonical URLs through Paragraph parents so nested embeds report the host page.
- Scope usage deletions to the current site's base URL to avoid clobbering other sites' records.
- Give DAM managers visibility of real content placements from within Bynder.
- Support license/compliance workflows by keeping Bynder's usage data accurate.
- Avoid orphaned usage records in Bynder after content is unpublished/removed.
- Integrate Drupal's Entity Usage tracking with the Bynder asset-usage API transparently.
- Log any Bynder usage API errors to the `bynder` channel for troubleshooting.
- Track usage across any entity type Entity Usage supports (nodes, paragraphs, etc.).
