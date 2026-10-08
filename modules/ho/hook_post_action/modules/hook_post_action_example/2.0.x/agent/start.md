<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook Post Action Example — agent index

Reference submodule of [hook_post_action](../../../../2.0.x/agent/start.md). Implements **all eight**
post-write hooks and logs to the `hook_post_action_test` channel on each entity/node
insert/update/delete. No config, no permissions, no services. Depends on `hook_post_action`.

- **What each handler does and the logged output** → [example.md](example.md)

Key facts:
- Implements `hook_entity_post{insert,update,delete,save}` and
  `hook_node_post{insert,update,delete,save}`.
- Each logs via `\Drupal::logger('hook_post_action_test')`; `*save` handlers use `$op`
  (insert/update/delete), mapped to past tense by `_hook_post_action_example_op_past_tense()`.
- To observe: enable, create/edit/delete content, read `admin/reports/dblog` (via a web request —
  hooks dispatch on request shutdown).
- Copy `hook_post_action_example.module` as a template for your own handlers.
