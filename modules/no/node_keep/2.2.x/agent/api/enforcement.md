# How Node Keep enforces protection

## Deletion — `hook_node_access()`

`node_keep_node_access($node, $op, $account)`:

- On `$op === 'delete'`, if the account **lacks** `administer node_keep per node` **and**
  `$node->get('node_keeper')->value` is truthy → returns `AccessResult::forbidden()` (cache
  contexts `user.permissions`, `url.path`).
- Unless `node_keep.settings.hide_warning_messages` is TRUE, on the node edit/delete routes it
  also adds a warning: *"This content has limited access permissions. You can preview, edit and
  update it, but it can only be removed by an administrator."*
- Otherwise returns `AccessResult::neutral()` (context `user.permissions`).

## Form-level hardening — `node_keep_form_node_form_alter()`

For users without `access node_keep widget`, the `node_keeper` / `alias_keeper` elements are set
`#access = FALSE`. For users with the widget but **without** `administer node_keep per node`:

- The checkboxes are `#disabled` (they can see but not change protection).
- If the node is protected (`node_keeper`), the **delete** and **delete_translation** actions are
  removed from the form.
- If `alias_keeper` is set, the Pathauto path widget (`$form['path']`) is hidden and the automatic
  alias checkbox forced off, preventing alias changes.

`node_keep_module_implements_alter()` re-orders the module's `form_BASE_FORM_ID_alter` to run
**after** `content_translation`.

## Notes for automation

- Protection is a per-node field value, not a permission — set it on the node entity.
- Enforcement only triggers for the **delete** operation and only through node access checks;
  a user with `administer node_keep per node` (or `bypass node access`) is never blocked.
- `alias_keeper` behaviour exists only when Pathauto is installed (the field isn't defined otherwise).
