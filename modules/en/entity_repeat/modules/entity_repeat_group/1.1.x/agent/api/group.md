<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group association flow

All logic is procedural in `entity_repeat_group.module`. Enable with `drush en entity_repeat_group`
(requires `entity_repeat` and contrib `group`). No config, routes, permissions or schema.

## entity_repeat_group_form_alter()

Runs on entity forms only (`is_a($form_object, EntityFormInterface)`). Gets the edited entity, then:
- `$group = $form_state->get('group')` — set by Group's *group content add* wizard. If present (add
  flow), stores `entity_repeat_group => $group`.
- Otherwise (edit flow) calls `_entity_repeat_group_get_group_content($entity)` and stores it as
  `entity_repeat_group_content`.
- If the entity is in no group (both empty), returns without altering.
- Merges those values into `$form_state` storage and appends `_entity_repeat_group_submit` to
  `$form['actions']['submit']['#submit']`.

`entity_repeat_group_module_implements_alter()` reorders this module's `form_alter` implementation to
run last, so its submit handler is appended after other modules'.

## _group_relationship_exists()

Returns TRUE if `\Drupal::entityTypeManager()->getDefinition('group_relationship', FALSE)` exists —
i.e. Group 3+. Used throughout to pick the modern API vs. the legacy Group 2 `group_content` API.

## _entity_repeat_group_get_group_content()

Entity-queries `group_relationship` (Group 3+) or `group_content` (Group 2) for
`entity_id == $entity->id()` with `accessCheck(FALSE)` (internal membership lookup, no output), loads
and returns the first match, or nothing if the entity is in no group.

## _entity_repeat_group_submit()

Runs after Entity Repeat has generated the clones. Resolves the target `$group` and the content
plugin/enabler id:
- edit flow: from the stored `group_content`, `getGroup()` and the plugin id
  (`getPluginId()` on Group 3+, `getContentPlugin()->getPluginId()` on Group 2).
- add flow: from the stored `entity_repeat_group`, with enabler from
  `$form_state->get('group_relation')` (Group 3+) or `->get('group_content_enabler')` (Group 2).

Then reads the key/value list `replications:{original-uuid}` (via Entity Repeat's
`_entity_repeat_get_kv()`), loads each clone by UUID, and adds it to the group with
`$group->addRelationship($replicate, $enabler)` (Group 3+) or `$group->addContent(...)` (Group 2).
Returns early if there are no replications.
