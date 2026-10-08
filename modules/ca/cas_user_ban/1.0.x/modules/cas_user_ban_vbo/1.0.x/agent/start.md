<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAS User Ban VBO (cas_user_ban_vbo) — agent index

Submodule of **cas_user_ban**. Adds a Views Bulk Operations user-cancel action that also bans the selected
users' CAS usernames. Core `^10 || ^11`; version 1.0.0.

## Dependencies
- `cas_user_ban` (parent) and `views_bulk_operations`.

## What it provides
- **VBO action plugin** `cas_user_ban_vbo_cancel_user_action` — class
  `Drupal\cas_user_ban_vbo\Plugin\Action\CancelUserAction` (`src/Plugin/Action/CancelUserAction.php`), declared
  with the `#[Action(id: 'cas_user_ban_vbo_cancel_user_action', label: 'Cancel the selected user accounts',
  type: 'user')]` attribute. It **extends VBO's** `views_bulk_operations\Plugin\Action\CancelUserAction` and
  mixes in the parent module's `UserCancelFormsTrait`.
- `buildConfigurationForm()` calls the trait's `addBanField()` (uids taken from `$this->context['list']`) to add
  the ban checkbox.
- `execute($account)` calls the parent cancel, then bans the account's CAS username only if the ban option is
  set, the account has a CAS username, and it is not the current user.
- No routes, no config schema, no permissions of its own.

## Access model
The action inherits access/execution from VBO's Cancel User Action (a `type: user` action, gated by the view's
access and VBO's per-entity cancel access); banning is a side effect of a cancel the operator is already allowed
to perform. Recommended over VBO's default cancel action when cas_user_ban is installed.

## Related docs
- Parent module: [../../../../agent/start.md](../../../../agent/start.md)
- The shared trait/event: [../../../../agent/api/extending.md](../../../../agent/api/extending.md)
