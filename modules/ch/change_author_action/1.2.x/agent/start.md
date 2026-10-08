# Change author action — agent index

Bulk **action** that reassigns node/media author (owner) to a chosen user via a two-step
confirm form + batch. Depends on the contrib `action` module. No settings page (`configure`
null), no module-defined permissions, no Drush. Provides (minimal) config schema.

- **The action plugin, the two shipped action configs, the confirm-form + batch flow, and the
  `administer users` gating** → [plugins/action.md](plugins/action.md)

Key facts:
- Plugin `change_author_action_base` (`src/Plugin/Action/ChangeAuthorActionBase.php`,
  `@Action`, `type = "node"`, `confirm_form_route_name = "change_author_action.form"`).
- Shipped action config entities: `change_author_action_base` (node) and
  `change_media_author_action_base` (media) in `config/install/`.
- `executeMultiple()` writes selected entities to private tempstore `change_author_ids` keyed by
  `currentUser->id()`, then core redirects to the confirm form.
- Confirm form route `change_author_action.form` → `/admin/change_author_action`, requirement
  `_permission: 'administer users'` (core, **`restrict access: TRUE`** → trusted admin).
- Batch `ChangeAuthorAction::updateFields()`: per entity, if owner differs →
  `setOwnerId($uid)` + `setNewRevision()` + `save()`.
- Plugin `access()` returns `$entity->access('update', $account, …)` — only editable entities
  are selectable.

Access: the state-changing form is gated by `administer users`, a
`restrict access: TRUE` permission, so only trusted admins can reassign authorship. A user
without `administer users` who triggers the action is stopped at the confirm form (access
denied). See [plugins/action.md](plugins/action.md) for detail.
