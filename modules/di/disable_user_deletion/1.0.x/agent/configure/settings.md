<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Disable user deletion

Form `SettingsForm` at `/admin/config/disable_user_deletion/settings` (route
`disable_user_deletion.settings_form`, permission `administer site configuration`). Three checkboxes
saved to config object **`disable_user_deletion.settings`**.

| Config key | Hides this core cancel method | Method label |
|---|---|---|
| `user_cancel_reassign` | `user_cancel_reassign` | Delete the account and make its content belong to Anonymous. |
| `user_cancel_delete` | `user_cancel_delete` | Delete the account and its content. |
| `user_cancel_block_unpublish` | `user_cancel_block_unpublish` | Disable the account and unpublish its content. |

(Note: core's non-destructive `user_cancel_block` — "Disable the account and keep content" — has no
toggle and is always left available.)

## How it works

`disable_user_deletion.module` alters both `user_cancel_form` and `user_multiple_cancel_confirm`. For
each enabled toggle it sets `$form['user_cancel_method'][<method>]['#access'] = FALSE` (hiding that
radio) and, if any were hidden, adds a warning: "Some options to delete users has been disabled…".

## Set via Drush

```bash
ddev drush cset disable_user_deletion.settings user_cancel_delete 1 -y
ddev drush cset disable_user_deletion.settings user_cancel_reassign 1 -y
ddev drush cset disable_user_deletion.settings user_cancel_block_unpublish 1 -y
```

## Caveat

This only removes options from the rendered form (`#access`). It adds **no server-side validation**,
and the parent `user_cancel_method` radios element still declares all core options, so the module does
not by itself prevent a crafted submission selecting a hidden method. It is a guardrail for trusted
admins (who already hold `administer users` / cancel-account rights), not an enforcement boundary.
