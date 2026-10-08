Store Drupal core Condition-plugin visibility rules on a block_content entity so they apply automatically across every placement of that reusable block.

---

Block Content Visibility exposes core's existing Condition Plugin System UI (User Role, Request Path, Language, and any contrib/custom conditions) directly on the block_content add/edit form. Rules are persisted in a revisionable `visibility_conditions` base field on the entity and evaluated at render time through `hook_block_access`, AND-combined with any placement-level conditions. This is a third, content-level layer of block visibility that complements core's plugin layer and placement layer: instead of repeating conditions on each `/admin/structure/block` placement, an editor sets them once on the content and every classic placement (and, for evaluation, Layout Builder inline block) honours them. The module is pure plumbing — it ships no new Condition plugins, requires the `block_form_alter` contrib module for its form alter, and its capability scales with whatever conditions are already enabled. It is presentational display control, not content-access enforcement.

---

- Gate a reusable promo banner placed in three regions on a single User Role condition set once on the content.
- Show a "VIP free shipping" banner only to a Mautic Segment across all of its placements without touching any placement form.
- Restrict a welcome block to one Language on the entity instead of once per theme placement.
- Let content editors who lack the "administer blocks" permission still control their block's visibility from the content form.
- Combine a Request Path condition and a User Role condition (AND-logic) on one block_content entity.
- Hide a seasonal block outside a Current Date / date-range condition provided by contrib.
- Carry visibility rules through Content Moderation revisions because the field is revisionable.
- Show an announcement block only on the front page using core's Front Page condition, applied at the content level.
- Apply an `entity_bundle:node` condition so a block appears only on node pages of a chosen type.
- Combine marketing-automation conditions (Mautic Audiences, Commerce customer metrics) on a single Black Friday banner.
- Keep placement-level and content-level visibility both in force — a block renders only when both layers pass.
- Warn a site builder editing a block placement that content-level conditions also exist, with a deep link to edit them.
- Honour a stored condition on a block_content revision used by a Layout Builder `inline_block:*` plugin at render time.
- Restrict which block_content bundles show the Visibility UI via the settings form (`enabled_bundles`).
- Hide noisy or context-dependent Condition plugins (e.g. `entity_bundle:commerce_product`) from the form while still evaluating any already-stored ones.
- Fail safe: a block with a condition whose required context is missing on a given page is forbidden rather than shown.
- Fail soft: an unbuildable or erroring condition degrades to neutral so it never takes the page down.
- Mark configured tabs with a check in the vertical-tabs UI so it is obvious at a glance which conditions gate a block.
- Require an explicit "Apply this condition" opt-in per tab so only rules the editor deliberately set are persisted.
- Revoke the `administer block content visibility` permission to hide the UI without silently dropping already-stored rules.
- Uninstall cleanly: the module transactionally removes the base field storage and purges stored data on uninstall.
