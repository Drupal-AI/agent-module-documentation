Block Visibility Groups lets you define named groups of block-visibility conditions once and then attach many blocks to a group, so all those blocks share one reusable set of condition rules instead of each block repeating the same visibility settings.

---

The module provides a `block_visibility_group` config entity: each group holds an ordered set of core/contrib **Condition** plugins (route, node type, user role, and — with CTools or other contrib condition modules installed — many more) plus a `logic` operator (`and` = all conditions must pass, `or` = only one must pass) and an `allow_other_conditions` flag. Groups are managed at **Admin → Structure → Block Layout → Block Visibility Groups** (`/admin/structure/block/block-visibility-group`), where you add a group, then add/edit/delete individual conditions on it through AJAX modal forms. Each Drupal block gains a "Condition Group" visibility plugin (`condition_group`) in its **Visibility** settings; picking a group there makes the block inherit that group's conditions. At render time the `GroupEvaluator` service loads the chosen group, applies plugin contexts, and resolves all its conditions with the group's AND/OR logic to decide whether the block is shown; the group's cache tags, contexts and max-age propagate to every block that uses it. If `allow_other_conditions` is off, blocks in the group have their per-block visibility options hidden so the group is the single source of truth. It is a lightweight alternative to Panels for context-driven block placement. Note: CTools is **not** a hard dependency (the info.yml requires only core `block`); it is recommended because it ships extra condition plugins the groups can use.

---

- Show a set of blocks only on a specific route/page by putting them all in one visibility group.
- Reuse one "front page only" condition set across a dozen blocks without re-entering it each time.
- Combine several conditions (e.g. route AND node type) into a single named rule shared by many blocks.
- Switch a whole cluster of blocks from "all conditions" (AND) to "any condition" (OR) by flipping one radio.
- Build a lightweight landing-page layout by grouping blocks under a page/route condition instead of using Panels.
- Restrict a group of blocks to authenticated users (or a specific role) via a User Role condition on the group.
- Show blocks only on a given content type using a Node Type condition on the group.
- Add entity-bundle or other advanced conditions to a group by installing CTools.
- Add a menu-position condition to a group via the Menu Condition module.
- Add a taxonomy-term condition to a group via the Term Condition module.
- Centralize maintenance: change a shared condition once and every block in the group updates.
- Hide per-block visibility options for blocks in a group so editors can't override the shared rules (`allow_other_conditions` off).
- Allow per-block extra conditions on top of the group's shared conditions (`allow_other_conditions` on).
- Assign a block to a group directly from the block's Visibility → Condition Group selector.
- Place blocks pre-filtered to a group from the group-aware "Place block" library.
- Negate a condition (e.g. show everywhere except one route) as part of a group's rule set.
- Export block visibility groups as configuration and deploy them between environments.
- Keep block cache tags/contexts correct automatically since the group propagates them to member blocks.
- Manage all conditions for many blocks from one administration form rather than block by block.
- Create block visibility groups programmatically in code or an update hook via the entity API.
- Evaluate whether a group's conditions currently pass in custom code using the `block_visibility_groups.group_evaluator` service.
- Model "show on section X of the site" once and reuse it for header, sidebar and footer blocks.
- Gate promotional blocks behind an OR group so any one of several routes triggers them.
- Reduce duplication and error on large sites where the same visibility logic repeats across regions.
- Group blocks so a single condition change during a campaign toggles all of them at once.
