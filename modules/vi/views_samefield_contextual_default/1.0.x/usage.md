<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Same field Contextual Default supplies a contextual filter's default argument by reading the same field's value from the entity in the current route.

---

The module registers a Views argument-default plugin, `samefield_contextual_default` ("Same field value from route context"). When a view's contextual filter on an entity field has no URL argument, the plugin loads the current route's entity via the route parameter, reads the matching field, and auto-detects its storage property (`value`, `target_id`, etc.) to extract the value(s). This removes the old pattern of hand-building a block or hacking a view in code just to pass in the current page's field value — useful for "related content sharing field X" blocks.

Options let you control multiple-value handling (OR joins with `+`, AND joins with `,`, or use only the first value), override the entity type and/or field name when they differ from the view's contextual filter, and — for taxonomy — swap matched terms for their parent term ids (via `loadAllParents()`), which pairs with the "Has taxonomy term ID (with depth)" filter. Configure it under a contextual filter's *When the filter is NOT available → Same field value from route context*; set validation to "Display all results for the specified field" for optional filters. The plugin caches on the `url` context.

---

- Show content related to the current page by a shared field value
- Build a "same category" related-content view without custom code
- Default a contextual filter from the current node's field
- Read the same field from a taxonomy term route
- Support commerce_product or any entity-type route parameter
- Join multiple field values with OR (`+`)
- Join multiple field values with AND (`,`)
- Use only the first value of a multi-value field
- Override the entity type looked up in the route
- Override the field name looked up in the route
- Filter by a term's parent instead of the term itself
- Pair with "Has taxonomy term ID (with depth)" for hierarchy filtering
- Auto-detect value vs target_id vs custom field property
- Display all results when the contextual value is absent
- Drive a sidebar block of related items from the current page
- Avoid per-view PHP or preprocess hacks for contextual arguments
- Cache results per URL for correctness
