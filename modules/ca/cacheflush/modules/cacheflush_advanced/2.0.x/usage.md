CacheFlush Advanced adds a "Custom (advanced)" tab to the CacheFlush preset form, letting a preset delete specific cache IDs (`$cid`) from a chosen cache bin and invalidate a list of cache tags.

---

The submodule implements `hook_cacheflush_ui_tabs()` to register a `vertical_tabs_advance` tab ("Custom (advanced)") and alters the preset add/edit forms (`hook_form_cacheflush_add_form_alter()` / `..._edit_form_alter()`). In that tab it renders an AJAX table where each row is a **Cache ID** text field plus a **Service** (cache bin) select, and a **Cache tags** text field. On validation (`cacheflush_advanced_tab_validation()`) each completed row is stored into the preset's `data['advanced']['functions']` as a call to `CacheflushApi::clearBinCache` with params `[<bin_service_id>, 'delete', <cid>]` (i.e. delete a specific cache id from that bin), and the comma-separated cache tags are stored into `data['cache_tags']['functions']` as a call to `CacheflushApi::clearCacheTags`. When the preset runs, those functions delete just those cache ids and invalidate those tags. It has no permissions, config, Drush, or plugins of its own; it depends on `cacheflush_ui`.

---

- Delete a single known cache id from a specific bin instead of clearing the whole bin.
- Clear a custom module's cache entry by its exact `$cid`.
- Invalidate specific cache tags (e.g. `node:5`, `node_list`) as part of a preset.
- Combine several targeted cid deletions into one preset.
- Add a targeted "menu:links" or similar cache-id clear to a maintenance preset.
- Invalidate a view's cache tag after content changes without a full flush.
- Build a preset that both deletes cids and invalidates tags in one run.
- Choose which bin service a cid deletion targets via the Service dropdown.
- Add multiple advanced rows dynamically with the AJAX "Add another row" button.
- Remove an advanced row before saving with the per-row Remove button.
- Invalidate a comma-separated list of cache tags from a single field.
- Target a render-cache entry precisely to avoid over-clearing.
- Clear a specific config or entity cache id after a deployment step.
- Pair targeted cid clears with the base preset options in the same preset.
- Provide power users a way to script fine-grained cache invalidation via presets.
- Invalidate a taxonomy term's cache tag after re-parenting.
- Delete an aggregated cache id created by a custom service.
- Keep production cache clears surgical to protect performance.
- Store the advanced selections in the preset's serialized data alongside standard options.
