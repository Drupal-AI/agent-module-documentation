<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# feeds_group_action — Group Membership target

## Add to a feed type
On the Feeds *mapping* page, map a source to the **Group Membership** target (`feeds_group_action_membership`). Its property is `group_id`.

## Target settings
- `relationship_plugin_id` (required) — the Group relation type (from `group_relation_type.manager`) to create.
- `add_method`:
  - `skip_existing` — do nothing if the relationship already exists.
  - `always_add` — always create a new relationship.
  - `update_existing` — update an existing relationship.

## Processing
`setTarget()` iterates the mapped values, normalises `group_id` (accepts a single value or an array), and stages each as `$entity->_feeds_group_action[] = ['group_id', 'relationship_plugin_id', 'add_method']`. `isEmpty()` is true when nothing was staged. The staged entries are consumed after entity save (module hooks) and executed through the Group Action API, which performs the actual group-content write.

Requires the `group_action` contrib module; behaviour of the create/update ultimately follows that layer.
