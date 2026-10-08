<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hook Post Action Example is the bundled reference submodule for hook_post_action: it implements every one of the new post-write hooks and writes a log message to the `hook_post_action_test` logger channel each time an entity/node is inserted, updated, or deleted, so you can see the hooks firing.

---

The submodule (depends on `hook_post_action`) is pure demonstration code with no configuration, permissions, or services. It implements all eight hooks the parent introduces: the entity-generic `hook_entity_postinsert/postupdate/postdelete/postsave` and the node-specific `hook_node_postinsert/postupdate/postdelete/postsave`. Each handler logs via `\Drupal::logger('hook_post_action_test')` a human-readable line naming the operation (a small helper `_hook_post_action_example_op_past_tense()` turns `insert`/`update`/`delete` into `inserted`/`updated`/`deleted`), the entity type or node bundle, the id, and the implementing function. To see it work you enable the module, create/edit/delete some content, and read the log at `admin/reports/dblog` (through a normal web request — the hooks are dispatched on request shutdown). It is meant to be read and copied as a template for writing your own `hook_post_action` handlers, not run in production.

---

- Confirm that hook_post_action's post-write hooks fire on your site by watching the dblog messages.
- See the exact function signatures for all eight hooks in a working implementation.
- Copy `hook_post_action_example.module` as a starting template for your own post-save handler.
- Learn the firing order of hook_ENTITY_TYPE_* vs hook_entity_* variants from real log output.
- Verify that `hook_entity_postsave($entity, $op)` reports the correct `$op` per operation.
- Demonstrate node-specific handling via `hook_node_postinsert/postupdate/postdelete`.
- Show non-developers that content changes are being observed after commit.
- Use the `hook_post_action_test` channel to filter just these demo messages in the log.
- Teach the past-tense op mapping pattern (`_hook_post_action_example_op_past_tense`).
- Smoke-test a hook_post_action upgrade by enabling the example and creating a node.
- Provide a quick "is hook_post_action working?" check during setup or debugging.
- Illustrate that the hooks apply to any entity type, not just nodes.
- Compare entity-generic vs entity-type-specific handlers side by side.
- Reference how to read `$entity->getEntityTypeId()`, `->id()`, and `->bundle()` in a handler.
- Serve as documentation-by-example alongside `hook_post_action.api.php`.
- Validate that deletes only log once the entity is truly removed.
- Enable temporarily in a dev environment to trace which saves trigger post actions.
- Show how to write a single `postsave` handler covering insert/update/delete.
- Provide a known-good implementation to diff against when your own handler misfires.
- Demonstrate logging as the side effect, replaceable with your own integration code.
