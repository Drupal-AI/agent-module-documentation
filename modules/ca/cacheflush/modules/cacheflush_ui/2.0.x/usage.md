CacheFlush UI provides the admin interface for building, listing and running CacheFlush presets, the granular per-preset permission model, and the option to expose a preset as an item in the admin menu.

---

The submodule turns the bare `cacheflush` entity into a fully manageable one via `hook_entity_type_alter()`: it attaches an access control handler, list builder, views data handler and add/edit/delete forms, and sets `field_ui_base_route` and link templates. Its routes give a collection at `/admin/structure/cacheflush`, add/edit/delete forms, and a settings tab. The preset form (`CacheflushEntityForm`) renders the whole option catalog (`cacheflush.api::getOptionList()`) as checkboxes grouped into **vertical tabs** declared by `hook_cacheflush_ui_tabs()` (Core cache tables, Other core cache options, Contrib cache tables, Other contrib cache options); ticking options and saving stores their functions into the preset's `data`. It adds a `menu` base field so a published preset can be exposed under the Cacheflush admin menu (`hook_menu_links_discovered_alter()` builds a link to the clear-by-id route). Access is governed by ten permissions with an **own/any** model implemented in `CacheflushEntityAccessControlHandler` (clear, view, edit, delete own/any, plus create and administer); a route subscriber adds `_entity_access: cacheflush.clear` to the clear-by-id route, and a `hook_views_query_alter()` lets users with *view any* see all presets in the `cacheflush_content` view. It also ships Action plugins (publish, unpublish, delete, add/remove menu) and a bulk-form Views field, plus config schema for those actions. It has no configure route of its own and no Drush.

---

- List all cache-flush presets at `/admin/structure/cacheflush`.
- Add a new preset via a form at `/admin/structure/cacheflush/add`.
- Edit or delete an existing preset from the collection.
- Pick which caches a preset clears using grouped vertical-tab checkboxes.
- Group clear options into Core tables, core functions, contrib tables and contrib functions tabs.
- Expose a frequently used preset as a link under the Cacheflush admin menu (`menu` field).
- Grant "clear own"/"clear any" preset permissions to different roles.
- Let editors create their own presets with "Create new Cacheflush entities".
- Restrict viewing/editing/deleting presets to owners with the own/any permissions.
- Give administrators full control via "Administer Cacheflush entities".
- Bulk publish/unpublish/delete presets with Views bulk actions.
- Add or remove a preset's admin-menu entry via the add-menu / remove-menu actions.
- Show a preset list filtered to the current user unless they have "view any".
- Provide a canonical view page for a preset at `/cacheflush/{id}`.
- Integrate presets with Field UI (add fields to the cacheflush entity).
- Control clear-by-id access through entity access (`cacheflush.clear`).
- Publish a preset automatically on save (the form sets status to TRUE).
- Surface presets in Views via the provided views_data handler.
- Offer a settings tab placeholder for future entity field settings.
- Let a role clear any preset without being able to edit or delete it.
