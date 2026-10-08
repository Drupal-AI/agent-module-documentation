<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook Post Action — agent index

A developer module that adds **eight new hooks** firing *after* an entity write is committed. No
config, no configure route (`configure: null`), no permissions, no services, no Drush. Implement the
hooks in your own module. Ships a `hook_post_action_example` submodule as a reference.

- **The eight hooks, their signatures, when they fire, and how to implement one** →
  [hooks/post-hooks.md](hooks/post-hooks.md)

Key facts:
- Hooks: `hook_entity_post{save,insert,update,delete}` and `hook_ENTITY_TYPE_post{save,insert,update,delete}`
  (e.g. `hook_node_postinsert`).
- `*postsave($entity, $op)` gets `$op` = `insert|update|delete`; the op-specific hooks get `($entity)`.
- Dispatched from a **shutdown function** (`drupal_register_shutdown_function`) after the write, via
  `moduleHandler()->invokeAll()`. Delete is confirmed by re-loading the entity (must be gone).
- Reference implementation of every hook: the `hook_post_action_example` submodule (logs to channel
  `hook_post_action_test`).
