<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Next.js Extras is an experimental companion to the Next.js module that adds a computed `content_translations` field on nodes (exposing translation URLs to the front end) and a legacy per-entity-type "Revalidate" toggle (now deprecated in favor of the core on-demand revalidation revalidators).

---

The submodule depends on `next` and layers on a few extras. `hook_entity_base_field_info()` adds a computed, multi-valued `content_translations` base field to nodes when `content_translation` is enabled, backed by the `ContentTranslationsItem` / `ContentTranslationsFieldItemList` field plugins, so a decoupled front end can read each node's available translations. `hook_form_next_entity_type_config_edit_form_alter()` adds an "Experimental" group to the entity-type config form with a **Revalidate** checkbox and a **Paths** textarea, stored as third-party settings `next_extras.revalidate` and `next_extras.revalidate_paths` on the `next_entity_type_config` entity (schema: `next.next_entity_type_config.*.third_party.next_extras`). That form now shows a **DEPRECATED** warning pointing to the parent module's on-demand revalidation; the parent's `next_update_9105()` migrates these third-party settings to the `path` revalidator. A `NextCacheInvalidator` service (`next_extras.cache_invalidator`) with HTTP-client-based path/entity invalidation remains for backward compatibility, and its `_next_extras_invalidate_entity_cache()` helper is explicitly deprecated. The module has no configure route of its own; its settings live on each `next_entity_type_config`.

---

- Expose a node's available translations to a Next.js front end via the computed `content_translations` field.
- Read translation URLs/langcodes in JSON:API output for building a language switcher in the front end.
- Toggle the legacy experimental "Revalidate" setting per entity type (deprecated).
- Store additional revalidate paths as a third-party setting on a `next_entity_type_config`.
- Migrate old `next_extras.revalidate` settings to the `path` revalidator (via the parent's update hook).
- Inspect existing sites for leftover `next_extras` third-party settings before removing the submodule.
- Use `NextCacheInvalidator` to invalidate a front-end path for a set of sites (legacy).
- Provide translation metadata for a multilingual decoupled site.
- Add translation awareness to nodes without writing a custom computed field.
- Audit which entity types still use the deprecated experimental revalidate toggle.
- Understand how earlier Next.js revalidation was configured before on-demand revalidators.
- Keep backward compatibility for sites upgrading from an older Next.js revalidation approach.
- Read `getThirdPartySetting('next_extras', 'revalidate')` in code to detect the legacy flag.
- Enable only on multilingual decoupled sites that need the translations field.
- Serve as a reference for adding a computed base field for decoupled consumption.
- Combine with `content_translation` so the `content_translations` field is populated.
- Remove/disable once you have migrated to the parent's `path`/`cache_tag` revalidators.
- Detect deprecated `_next_extras_invalidate_entity_cache()` usage during an upgrade audit.
- Configure per-type revalidate paths (e.g. `/blog`) in the experimental form for legacy setups.
- Feed translation links to a headless front end's hreflang tags.
