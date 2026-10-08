<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Entityqueue — agent index

Automatically adds newly created entities to Entityqueue subqueues when the entity's type +
bundle match a queue that has **auto-add** turned on. Pure hook glue on top of the
`entityqueue` module: `hook_form_alter` adds the toggles, `hook_entity_insert` does the work.
No configure route, no permissions, no Drush, no config schema of its own — state lives on each
**EntityQueue** config entity (`entity_queue.*`).

- **Enable auto-add on a queue, the two options, where stored, insert order & max_size** →
  [configure/auto-add.md](configure/auto-add.md)

Key facts:
- Toggles stored at `entity_queue.<id>` →
  `entity_settings.handler_settings.auto_entityqueue.auto_add` (bool) and `.insert_front` (bool).
- Only fires for **new** entities (`hook_entity_insert`), for **enabled** queues whose
  `target_bundles` include the entity's bundle.
- `insert_front` prepends (else appends); when `queue_settings.max_size` is reached it pops the
  opposite end first. Applies to **all subqueues** of a matching queue.
