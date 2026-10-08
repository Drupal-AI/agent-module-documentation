<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js Extras — agent index

Experimental companion to [next](../../../../2.1.x/agent/start.md). Two things: a computed
`content_translations` node field (for decoupled translation URLs) and a **deprecated** per-entity-type
"Revalidate" toggle stored as `next_extras` third-party settings. Depends on `next`. No configure
route of its own.

- **The extras: computed field, third-party revalidate settings, cache invalidator** →
  [extras.md](extras.md)

Key facts:
- Computed field `content_translations` added to nodes via `hook_entity_base_field_info()` (needs
  `content_translation`); plugins `ContentTranslationsItem` / `ContentTranslationsFieldItemList`.
- Legacy "Revalidate" checkbox + "Paths" textarea on the `next_entity_type_config` edit form, stored
  as third-party settings `next_extras.revalidate` (bool) and `next_extras.revalidate_paths` (string).
  Marked **DEPRECATED** → use the parent's on-demand revalidation (`path`/`cache_tag`) instead.
- Service `next_extras.cache_invalidator` (`NextCacheInvalidator`) — legacy HTTP-based invalidation.
- Config schema: `next.next_entity_type_config.*.third_party.next_extras`.
