<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable user deletion — agent index

Hides chosen account-cancellation methods from core's `user_cancel_form` and
`user_multiple_cancel_confirm` forms via `#access = FALSE`. Config route
`disable_user_deletion.settings_form` (`/admin/config/disable_user_deletion/settings`, permission
`administer site configuration`). No own permission, no Drush, no plugins.

- **Settings toggles, config keys, the UI-only caveat** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `disable_user_deletion.settings` with booleans `user_cancel_reassign`,
  `user_cancel_delete`, `user_cancel_block_unpublish` (core `user_cancel_*` method ids).
- When a toggle is on, `disable_user_deletion.module` sets `#access = FALSE` on that method's radio in
  both cancel forms and adds a warning message.
- UI-only guard: it does not add server-side validation of the submitted `user_cancel_method`; treat
  it as a convenience guardrail for trusted admins, not an access control.
