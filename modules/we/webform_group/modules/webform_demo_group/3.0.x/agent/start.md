# Webform Demo: Group — agent index

Demo/example submodule of `webform_group`. On install it programmatically builds a full working
example of the Webform + Group integration. Not for production.

No config UI, no permissions, no services of its own. Key behavior lives in install hooks.

Key facts:
- `hook_install()` (`webform_demo_group.install`) creates group types `webform_group_a` /
  `webform_group_b` with roles (administrator, manager, member, reviewer, outsider, anonymous),
  the `webform_group_contact` webform (handlers disabled), demo groups, users, generated
  submissions, and `/webform/group` path aliases.
- `config/install/*` ships the group types, group roles, relationship types, the webform, and its
  form/view displays.
- `webform_demo_group.module`: one `hook_block_access()` that hides the `group_operations` block
  outside group context in the Bartik theme.
- Parent module docs: [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
