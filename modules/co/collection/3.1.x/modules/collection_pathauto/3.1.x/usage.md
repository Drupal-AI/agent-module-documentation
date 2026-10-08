<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Collection submodule that prepends a canonical collection's URL alias to the Pathauto alias of the content it collects.

---

Collection Pathauto integrates the Collection module with Pathauto. When a content entity is placed in a collection and that collection item is marked *canonical* (its primary/home collection), this submodule prefixes the entity's Pathauto-generated alias with the URL alias of the collection. For example, if a `post` node's pattern is `post/[node:title]` and it is canonically collected in a collection aliased `my-blog`, the resulting alias becomes `my-blog/post/[node:title]`. It hooks into Pathauto alias generation (`hook_pathauto_alias_alter`) and also subscribes to Collection's item create/update/delete events, so the collected entity's alias is regenerated whenever it is added to, removed from, or loses canonical status in a collection. A further alter hook (`hook_collection_pathauto_alias_alter`) lets other modules tweak the combined alias. Requires the Pathauto module.

---

- Prefix a collected entity's URL alias with its canonical collection's alias.
- Apply only to the item's canonical (primary) collection, not every collection it belongs to.
- Regenerate the collected entity's alias when its collection membership or canonical flag changes.
- Expose `hook_collection_pathauto_alias_alter()` for further alias customization.
- Model blog- or subsite-style nested URLs (e.g. `my-blog/post/title`) without manual aliasing.
