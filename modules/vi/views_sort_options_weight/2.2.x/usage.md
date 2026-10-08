Views Sort By Options Weight adds Views sort handlers that order results by an admin-assigned weight per value — for the allowed values of a list field, for an entity type's bundles, or for user roles — instead of sorting alphabetically or numerically by the stored value.

---

The module provides three Views sort plugins built on a shared base (`ExtendedSortByWeightBase extends views\Standard`): `extended_sort_by_options_weight` (weights each allowed value of a `list_string`/`list_integer`/`list_float` field), `extended_sort_by_bundles_weight` (weights each bundle of an entity type), and `extended_sort_by_user_role_weight` (weights each user role). `hook_views_data_alter` and `hook_field_views_data_alter` expose these as extra "(set weight)" sort fields next to the relevant real field/bundle/role field in the Views UI. When you add one of these sorts, its options form lists every value with a numeric weight box (defaulting to sequential 1, 2, 3…); the plugin then builds an SQL `ORDER BY CASE … WHEN <column> = '<value>' THEN <weight> … ELSE 1000 END` expression so rows sort by your chosen weights, with unmatched values falling to weight 1000. The user-role handler maps the "Authenticated user" role to a NULL-value branch (since that membership isn't stored in `user__roles`). These sorts cannot be exposed to end users (`canExpose()` returns FALSE). Configuration lives entirely inside the view; there is no admin settings page, permission, or Drush command. Supports Drupal 8.9 through 11 and requires only core Views.

---

- Sort content by a custom priority order of a select-list field (e.g. status: Critical → High → Low) rather than alphabetically.
- Order a view of articles by a "priority" list field using explicit weights.
- Sort a taxonomy/entity view so specific bundles appear before others (e.g. Page before Article before Blog).
- Put "featured" content types at the top of a mixed-entity listing via bundle weights.
- Order a user list by role importance (Administrator → Editor → Member) instead of role machine name.
- Give each allowed value of a `list_integer` field its own sort weight.
- Sort a `list_float` field's options in a non-numeric, curated order.
- Rank order-status values (Pending, Processing, Shipped, Delivered) in workflow order in a view.
- Move a catch-all / "Other" option to the end of a sorted list by giving it a high weight.
- Provide editorial control over listing order without adding a separate weight field to every entity.
- Combine a weighted-options sort with a secondary sort (date, title) for tie-breaking.
- Sort event sessions by a "track" list field in a deliberate presentation order.
- Order a directory of members by membership tier (a role) rather than by name.
- Keep unmatched/legacy field values grouped at the bottom (they map to weight 1000).
- Build an admin report that lists nodes grouped by a status field in escalation order.
- Reorder bundles in a block view (e.g. show promotional content types first).
- Apply the same curated ordering across many views by re-adding the sort handler.
- Sort ascending or descending on the weighted expression via the standard sort order option.
- Avoid alphabetical accidents (e.g. "High" sorting before "Low" before "Medium") on status fields.
- Present a faceted/filtered list in a business-meaningful order defined by content editors.
