<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview mechanism: request flag + revision swap

Two services drive preview: the negotiation subscriber (sets a per-request flag) and the state
manager (does the revision math and swap).

## Request flag — PreviewNegotiationSubscriber

`src/Events/PreviewNegotiationSubscriber.php` (service tagged `event_subscriber`).

- Listens on `KernelEvents::REQUEST` priority 14 → `setPreview()`.
- Asks `PreviewDetectorPluginManager::activeDetector($request)` and stores two request attributes:
  `PreviewNegotiationSubscriber::IS_PREVIEWING` (`_is_previewing`, bool) and `ACTIVE_DETECTOR`
  (`_active_detector`, the plugin id or NULL). Everything else reads these attributes.

## State manager — EntityStateManager

`src/Entity/EntityStateManager.php` (service, args `@entity_type.manager`, `@language_manager`,
`@request_stack`). Constructor caches `isPreviewing` from the request attribute.

- `isPreviewing(): bool` — the cached flag.
- `findRevisionId($entity_type_id, $entity_id)` / `findRevisionIds(...)`: non-revisionable storage →
  returns the id unchanged; not previewing → returns the current (default) revision id; previewing →
  resolves the **latest translation-affected revision** using `ancestorLangcodes()` (built from
  `LanguageManager::getFallbackCandidates()` + default language) via
  `getLatestTranslationAffectedRevisionId()`, falling back to `getLatestRevisionId()`.
- `maybeSwapEntities(array $entities, ?AccountInterface $account = NULL)`: the Views-path swap. Returns
  input unchanged if not previewing. For each latest revision it loads: if the revision id equals the
  original, or **`$entity->access('view', $account)` is FALSE**, it keeps the original entity;
  otherwise it marks `$entity->in_preview = TRUE` and substitutes the latest revision. Access is
  enforced here before any swap.
- `isLiveVersion(EntityInterface $entity): bool` — TRUE if the entity is effectively the live/default
  revision (mirrors content_moderation's pending-revision logic); used to decide whether a draft
  indicator is needed. `getDefaultRevisionId()` uses an entity query with `accessCheck(FALSE)`
  deliberately (an id-only API lookup, renders nothing).
- `getLatestRevisionId(EntityInterface $entity)` — latest revision id for the indicator message.

## Cache contexts

`src/Cache/StatusPreviewCacheContext.php` (context id `entity_reference_preview`) digests each
detector's preview state into a cache key and depends on `config:entity_reference_preview.settings`.
`WithIndicatorCacheContext` / `WithoutIndicatorCacheContext` (ids
`entity_reference_preview.with_indicator` / `.without_indicator`) let indicator/non-indicator variants
cache separately. Defined in `entity_reference_preview.services.yml`.
