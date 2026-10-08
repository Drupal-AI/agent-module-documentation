<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content — agent index

A framework for real-time, client-side personalization. Site builders define **Segments** (named
groups of **Conditions**), collect them into a **Segment Set**, and attach a **Reaction** to each
segment inside a **Decision**. At page load the module renders a placeholder plus JS settings; a
browser "agent" evaluates each segment's conditions client-side, picks the first matching segment,
and fetches that segment's reaction over an AJAX endpoint keyed by a per-instance UUID token — so the
host page stays cacheable. Everything (condition, condition-type, decision, reaction, storage) is a
plugin.

Depends on Drupal core only (`^9.1 || ^10`). No settings form (`configure` null); admin lives at
`/admin/structure/smart-content` behind permission `administer smart content`. Ships two submodules
in the same package: **smart_content_block** (the Decision Block + block reaction, the usual entry
point) and **smart_content_browser** (browser/device conditions).

- **Define/extend condition, condition-type and condition-group plugins** → [plugins/conditions.md](plugins/conditions.md)
- **Define/extend reaction plugins (and the bundled Block reaction)** → [plugins/reactions.md](plugins/reactions.md)
- **Decision + decision-storage + segment-set-storage plugins; the end-to-end runtime flow and JS agent** → [plugins/decisions.md](plugins/decisions.md)
- **Services, plugin managers, entities, the Decision field type, events, the AJAX reaction endpoint** → [api/services.md](api/services.md)
- **Admin route, permission, global Segment Set config entity + schema, creating a segment set in PHP** → [configure/segment-sets.md](configure/segment-sets.md)
- **Placing a Decision Block and how it stores its decision** → [blocks/decision-block.md](blocks/decision-block.md)

Key facts:
- Permission: `administer smart content` (admin_permission on both config entities).
- Admin menu route: `system.admin_structure_smart_content` → `/admin/structure/smart-content`.
- Reaction endpoint route: `smart_content.reaction` → `/ajax/smart_content/{decision_storage}/{token}/{reaction}` → `ReactionController::getReactionResponse`, permission `access content`. `token` and `reaction` must be valid UUIDs.
- Plugin managers / service ids: `plugin.manager.smart_content.condition`, `.condition_type`, `.condition_group`, `.reaction`, `.decision`, `.decision_storage`, `.segment_set_storage`.
- Plugin annotations: `@SmartCondition`, `@SmartConditionType`, `@SmartConditionGroup`, `@SmartReaction`, `@SmartDecision`, `@SmartDecisionStorage`, `@SmartSegmentSetStorage`. Plugin dir `Plugin/smart_content/…`.
- Config entities: `smart_content_decision_config` (prefix `smart_content.smart_content.decision`), `smart_content_segment_set` (prefix `smart_content.smart_content.segment_set`). Content entity: `smart_content_decision_content`. Field type: `smart_content_decision` (internal, `no_ui`).
- Config schema keys: decision `settings` (id/default/segmentStorage/token/storage_id/reactions); segment (uuid/weight/label/default/conditions); condition (id/weight/negate/type).
- DB tables (in `smart_content.install`): `decision_config_token`, `decision_content_token`, `decision_content_usage`.
- Bundled decision plugin `multiple_block_decision`, reaction plugin `display_blocks`, block `smart_content_decision_block` (all in smart_content_block).
