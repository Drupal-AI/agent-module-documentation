<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (`sharedemail.permissions.yml`)

| Machine name | Gates |
|---|---|
| `administer shared email` | Access to the settings form `sharedemail.settings_form` (`/admin/config/people/shared-email`). |
| `access shared email message` | Whether the `sharedemail_msg` warning is displayed to the user after they save an email already used by another account. |
| `create shared email account` | The uniqueness **bypass**. Only users with this permission can save a duplicate email — and only when the address is on the `sharedemail_allowed` allowlist (or the allowlist is empty). Without it, core-style email uniqueness is enforced. |

Notes:
- `create shared email account` is the functional switch: it decides who may reuse an email; the allowlist
  (`sharedemail_allowed`) narrows *which* emails they may reuse.
- `access shared email message` is purely informational (the warning), not an access control.
- There is no permission that disables the constraint globally; enabling/disabling the module does that.
