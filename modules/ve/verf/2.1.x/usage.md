Views Entity Reference Filter (verf) adds a user-friendly Views filter for entity reference fields: instead of typing entity IDs, site builders and visitors pick referenced entities by their labels from a select/checkbox list.

---

The module implements `hook_views_data_alter()` to add a companion "(VERF selector)" filter alongside every entity reference field's `_target_id` column — both for configurable fields (`field_config` of type `entity_reference`) and for base fields whose storage is `entity_reference` on SQL-backed fieldable entity types. Selecting that filter in the Views UI activates the `verf` filter plugin (`Drupal\verf\Plugin\views\filter\EntityReference`), which extends core's `InOperator`. The plugin loads the referenceable target entities, resolves each one to its label (respecting content-language translations and `view label` access, showing "- Restricted access -" when only the entity is hidden), natcase-sorts them, and presents them as the exposed filter's value options. Two extra handler options are offered in the filter settings form: "Target entity bundles to filter by" (`verf_target_bundles`, shown only when the target entity type is bundleable) restricts the option list to chosen bundles, and "Ignore access control" (`show_unpublished`) includes entities the current user cannot `view`. The filter emits proper cacheability metadata (tags, contexts, max-age merged from the view and the target entity type's list cache metadata). A `hook_verf_entites_options_alter()` alter lets other modules add or remove entities from the option list. The module ships a config schema for the filter, requires core Views, and adds no admin UI, routes, permissions, or Drush commands of its own.

---

- Let visitors filter a View of content by a referenced entity's label (e.g. "Category", "Author", "Tag") instead of a numeric entity ID.
- Add an exposed dropdown of referenced entity titles to a public listing page.
- Filter nodes by an entity-reference field pointing at another content type, choosing target nodes by title.
- Filter by a taxonomy term reference where editors pick term names rather than term IDs.
- Filter by referenced users, media, or any custom entity type using their labels.
- Provide an admin-facing exposed filter that is friendlier than the default "numeric entity ID" filter.
- Restrict the selectable options to specific bundles of the target entity type (e.g. only "Article" and "Page" nodes).
- Build a faceted-style listing where each entity reference field becomes a label-based select filter.
- Filter on a base entity-reference field such as a node's author (`uid`) by username.
- Present referenced options as checkboxes for multi-value ("IN") filtering across several targets at once.
- Show translated entity labels in the filter options for the current content language.
- Include unpublished or access-restricted target entities in the filter by enabling "Ignore access control".
- Keep restricted entities' existence hidden by rendering them as "- Restricted access -" when only their label is viewable.
- Ensure filter results are correctly cached by relying on the plugin's merged cache tags/contexts/max-age.
- Programmatically add virtual or computed entities to a filter's option list via `hook_verf_entites_options_alter()`.
- Remove specific entities (e.g. archived records) from a VERF filter's options with the alter hook.
- Replace a hand-built "entity autocomplete" exposed filter with a curated select list of labels.
- Give content teams a report View whose reference filters read in plain language.
- Filter commerce or catalog content by a referenced product/brand entity by name.
- Offer an exposed filter for a "related content" reference field so users browse by the related item's title.
- Sort the option list naturally (case-insensitive) so labels appear in human-friendly order.
- Combine the VERF selector with other exposed filters and sorts on the same View.
- Expose the same reference field as a filter on multiple View displays (page, block, attachment).
- Migrate away from manually maintained allowed-values lists by deriving options live from referenced entities.
- Filter grouped/mini-pager listings by referenced entity without exposing internal IDs to end users.
