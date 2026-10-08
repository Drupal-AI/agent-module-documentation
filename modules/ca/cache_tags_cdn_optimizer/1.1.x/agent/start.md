<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Tags CDN Optimizer (cache_tags_cdn_optimizer) — agent index

Reshapes Drupal core cache tags so a CDN/purge backend clears cached pages only when needed.
Rewrites *referenced-entity* tags `node:123` → `node:reference:123` (and same for `taxonomy_term`)
on the response, then invalidates those `:reference:` tags **only when a configured field changes**.
No external HTTP/CDN client of its own — it only manipulates core cache tags + `Cache::invalidateTags()`.
Version 1.1.0. Core `^10 || ^11 || ^12`. No module dependencies. License GPL-2.0-or-later.

## What it provides

- **Event subscriber** `cache_tags_cdn_optimizer.event_subscriber` →
  `KernelResponseEventSubscriber::onKernelResponse` (priority `1`, patch via
  `SettingsTrait::$DEFAULT_EVENT_PRIORITY`). Rewrites the response's cache-tags header.
- **Hooks** in `cache_tags_cdn_optimizer.module`: `hook_entity_insert`, `hook_entity_update`,
  `hook_entity_delete` — the actual `Cache::invalidateTags()` calls (nodes & taxonomy terms only,
  plus `path_alias` for the path-tag feature).
- **Settings form** `SettingsForm` at route `cache_tags_cdn_optimizer.settings`
  (`/admin/config/services/cache-tags-cdn-optimizer`, permission `administer site configuration`),
  incl. an AJAX "invalidate this tag now" utility (`invalidateCacheTagAjax`).
- **Config object** `cache_tags_cdn_optimizer.settings` (schema in `config/schema/`).
- **Trait** `SettingsTrait` — shared constants + `convertPathToTag()`.
- No permissions of its own, no Drush, no plugins, no entities.

## Docs

- Config keys, the settings form, routes/permissions → [config/settings.md](config/settings.md)
- The tag-rewrite + invalidation mechanism (subscriber + hooks) → [api/mechanism.md](api/mechanism.md)

## Key facts (from source)

- Reference-tag suffix is the literal `reference` (`SettingsTrait::$CUSTOM_TAG_SUFFIX`); path-tag
  prefix is `url` (`$PATH_CACHE_TAG_PREFIX`), built by `convertPathToTag()`.
- Replacement only applies when `replace_cache_tags_node` / `replace_cache_tags_taxonomy_term` are on;
  the entity being *directly viewed* keeps its normal `node:123` tag.
- On the response it also appends `<entityType>:<bundle>:purge_all` for the current entity.
- Update-time invalidation compares each configured field's old vs new value (`$entity->original`);
  only a real change triggers the `:reference:` invalidation. `debug_mode` logs the comparison.
