<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Reference Extras replaces the `viewsreference.compression` service so an AJAX-enabled embedded view forwards a tiny "reload" pointer instead of all its serialized field settings — curing the HTTP 414 (URI Too Long) errors that heavily-configured Views Reference fields hit when a pager or exposed filter fires. There is nothing to configure: enabling the module swaps the service in.

---

Views Reference Field lets a field reference a view + display and embed it on an entity. When that embed runs with AJAX (a pager, exposed filter, or sort), core's Views AJAX carries the field's settings in the request so the reloaded view is rebuilt identically. Parent `viewsreference` does this by JSON-encoding the whole `#viewsreference` array (view name, display id, `enabled_settings`, and the serialized `data` blob of every setting plugin's stored value) and gzip-packing it into a `compressed` query parameter (`ViewsReferenceCompression`, wired as `viewsreference.compression`). For a field whose settings include a large options list — e.g. a taxonomy-term filter with hundreds of checkboxes — even the compressed string can blow past the server's URI length limit, and the AJAX request comes back **HTTP 414**. Views Reference Extras' `viewsreference_extras.services.yml` re-declares the same service id, `viewsreference.compression`, pointing it at `ViewsReferenceExtrasCompressionReload`. Its `compress()` **drops the bulky `data`** (and any prior `compressed`) from the array and stores only a small `reload` parameter — a gzip-packed JSON of the remaining pointer fields the parent formatter already records on the render element: `parent_entity_type`, `parent_entity_id`, `parent_revision_id`, `parent_entity_langcode`, `parent_field_name`, and `field_item_delta`. On the return AJAX request `uncompress()` reads `reload`, loads that entity (a specific revision via `RevisionableStorageInterface::loadRevision()` when a revision id is present, else `load()`), switches to the recorded translation so translation-dependent settings re-derive correctly, and **re-reads the `data` blob straight from the field item(s)** on the freshly-loaded entity — `unserialize(..., ['allowed_classes' => FALSE])`. Because the settings come back from the stored entity rather than the URL, the AJAX URL stays short no matter how many options the field carries. Before re-reading the field it calls `$entity->access('view', $currentUser)`, an explicit guard the parent service does not have, so a tampered `reload` pointer cannot pull settings out of an entity the current user may not view. The swap is global and automatic — every Views Reference field on the site uses the reload strategy once the module is enabled; there is no per-field opt-in and no admin UI. The module ships only this service class plus tests (a functional-JS test exercising the 414 scenario with `views_ajax_history`, and a kernel test covering the translation/langcode restore); it defines no fields, no ViewsReferenceSetting plugins, no permissions, no config, and no Drush commands.

---

- Fix HTTP 414 errors on an embedded view's AJAX pager.
- Fix 414 errors when an embedded view's exposed filter is submitted via AJAX.
- Embed a view whose field settings include a very large options list (hundreds of term checkboxes).
- Keep the AJAX request URL short regardless of how many Views Reference settings are set.
- Stop passing serialized field-setting `data` in the query string.
- Reload embedded-view settings from the source entity on each AJAX request.
- Preserve the correct translation when an AJAX-paged embed is re-derived.
- Preserve the correct revision when re-reading a viewsreference field's settings.
- Enable a global compression override with no configuration.
- Support AJAX-paged view embeds on nodes with many field settings.
- Let a related-content or events embed page/filter without hitting URI limits.
- Harden the settings-reload path with a per-entity `view` access check.
- Avoid gzip-compressing a huge settings payload on every AJAX view render.
- Replace `viewsreference.compression` cleanly via a same-id service definition.
- Keep Views Reference Field itself lean by moving the reload feature into a companion module.
- Support multi-value viewsreference fields (per-delta settings via `field_item_delta`).
- Restore settings for a specific field item (delta) on a multi-value embed.
- Provide a drop-in remedy for the parent module's #3396530 limitation.
- Keep exposed-filter AJAX working on large filtered views embedded in content.
- Run automatically after `drush en viewsreference_extras` with no post-install steps.
- Serve as a base for future opt-in Views Reference feature additions.
- Avoid duplicating a view display just to shrink its AJAX settings payload.
